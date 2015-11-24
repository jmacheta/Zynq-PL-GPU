`timescale 1ns / 1ps
module pixel_arbiter
#(  
    parameter ADD_WIDTH = 16,
    // parameter BLOB_ADD_WIDTH = 5,    
    parameter NR_OF_BLOBS    = 2,      //1 << BLOB_ADD_WIDTH
    parameter NR_OF_RAMS     = 5        //TBD
) 
(
    // system inputs
    input clk,  // system clock   
    input reset,    // sycnhronous reset
    
    // control registers
    // background color
    input [11:0] background,
    
    // sprites' layers
    input [1:0] layer [NR_OF_BLOBS-1:0],
    // sprites' location in RAM
    input [ADD_WIDTH-1:0] address [NR_OF_BLOBS-1:0],
    // requests from blobs
    input [NR_OF_BLOBS-1:0] request,
    
    // BRAM write ports
    input [ADD_WIDTH-1:0]  wr_add,
    input [11:0] wr_data,
    input        wr_req,
    
    // pixel send to VGA
    output logic [11:0] pixel_send
    
);
    
    int i,j;
    
    // capture requests
    // IDs of blobs that send reqest for specific layer
    int layer0_blob_id = 0;
    int layer1_blob_id = 0;
    int layer2_blob_id = 0;
    int layer3_blob_id = 0;
    // flag indicating on which layers there were requests
    logic [3:0] layer_req;
    // latched addresses of current pixel from blobs
    logic [ADD_WIDTH-1:0] latched_address [NR_OF_BLOBS-1:0];
    
    always @(posedge clk) begin
        if (reset) begin
            layer_req <= 4'h0;
        end else begin
            // at init: clear request for all layers 
            layer_req <= 4'h0;
            for (i=0; i<NR_OF_BLOBS; i++) begin
                // latch current adress from blob
                latched_address[i] <= address[i];
                if (request[i])
                    case (layer[i])
                        2'b00: begin
                            layer0_blob_id <= i;
                            layer_req[0] <= 1;
                        end
                        2'b01: begin
                            layer1_blob_id <= i;
                            layer_req[1] <= 1;
                        end
                        2'b10: begin
                            layer2_blob_id <= i;
                            layer_req[2] <= 1;
                        end
                        2'b11: begin
                            layer3_blob_id <= i;
                            layer_req[3] <= 1;
                        end
                    endcase            
            end  
        end
    end
    
    // delay 'layer_req' register value
    localparam delay = 6;
    logic [3:0] layer_req_srl[delay-1:0];
    
    initial begin
        for (j=0; j <delay; j++)
            layer_req_srl[j] <= 0;
    end
    
    always @(posedge clk) begin
        layer_req_srl[0] <= layer_req;
        for (j=1; j <delay; j++)
            layer_req_srl[j] <= layer_req_srl[j-1];
    end
    
    // capture address of pixels for all layers
    logic [ADD_WIDTH-1:0] layer0_add;
    logic [ADD_WIDTH-1:0] layer1_add;
    logic [ADD_WIDTH-1:0] layer2_add;
    logic [ADD_WIDTH-1:0] layer3_add;
    
    always @(posedge clk) begin
        if (layer_req!= 4'h0) begin
            layer0_add <= latched_address[layer0_blob_id];
            layer1_add <= latched_address[layer1_blob_id];
            layer2_add <= latched_address[layer2_blob_id];
            layer3_add <= latched_address[layer3_blob_id];
        end
    end
    
    // simple FSM which drives read request and read address:
    // init (pixel_send = background); if any request ===> rd3
    // rd3===> rd2
    // rd2===> rd1
    // rd1===> rd0
    // rd0===>rd3 and so on...
    logic [4:0] state;
    // states
    localparam init = 5'b00001;
    localparam rd0  = 5'b00010;
    localparam rd1  = 5'b00100;
    localparam rd2  = 5'b01000;
    localparam rd3  = 5'b10000;
    
    always @(posedge clk) begin
        if (reset)
            state <= init;
        else case (state)
            init:
                if (layer_req[0] | layer_req[1] | layer_req[2] | layer_req[3])  // any request?
                    state <= rd3;
            rd3:
                state <= rd2;
            rd2:
                state <= rd1;
            rd1:
                state <= rd0;
            rd0:
                state <= rd3;                
        endcase
    end
    
    // delayed state values
    logic [4:0] state_d0,state_d1,state_d2;
    always @(posedge clk) begin
        if (reset) begin
            state_d0 <= init;
            state_d1 <= init;
            state_d2 <= init;
        end else begin
            state_d0 <= state;
            state_d1 <= state_d0;
            state_d2 <= state_d1;
        end
    end
    
    logic [ADD_WIDTH-1:0] rd_add;
    always @(posedge clk) begin
        case (state)
        rd3 : rd_add <= layer3_add;
        rd2 : rd_add <= layer2_add;
        rd1 : rd_add <= layer1_add;
        rd0 : rd_add <= layer0_add;
        default : rd_add <= 0;
        endcase
    end
    
    //TBD: use generate for multiply RAMs?
    // RAM
    logic [11:0] rd_data; // 12-bit pixel
    ram #(
        .ram_width(ADD_WIDTH),
        .data_width(12)
    )
    pixel_ram (
        .wr_clk(clk),
        .wr_add(wr_add),
        .wr_data(wr_data),
        .wr_req(wr_req),
        .rd_clk(clk),
        // .rd_req(rd_req),
        .rd_add(rd_add),
        .rd_data(rd_data)
    );
        
    // check read data and choose non-transaparent one from the highest layer that send request (or background)
    logic [11:0] updating_pixel;
    // flag indicating that pixel was chosen
    logic pixel_chosen = 0; 

    // note: possible need for fixes in sense of timing closure (for example: update flag + rd_data delayed)
    always @(posedge clk) begin
        case (state_d1)
            rd3:
                if ( (rd_data != 12'h000) & (!pixel_chosen) & layer_req_srl[delay-4][3] ) begin
                    updating_pixel <= rd_data;
                    pixel_chosen <= 1;
                end
            rd2:
                if ( (rd_data != 12'h000) & (!pixel_chosen) & layer_req_srl[delay-3][2] ) begin
                    updating_pixel <= rd_data;
                    pixel_chosen <= 1;
                end
            rd1:
                if ( (rd_data != 12'h000) & (!pixel_chosen) & layer_req_srl[delay-2][1] ) begin
                    updating_pixel <= rd_data;
                    pixel_chosen <= 1;
                end
            rd0: begin
                if ( (rd_data != 12'h000) & (!pixel_chosen) & layer_req_srl[delay-1][0])
                    updating_pixel <= rd_data;
                else if (!pixel_chosen)
                    updating_pixel <= background;
                pixel_chosen <= 0;
                
            end
            default: begin
                updating_pixel <= background;
                pixel_chosen <= 0;
            end
        endcase
    end
    
    // finally send pixel
    always @(posedge clk) begin
        if (state_d2 == init)
            pixel_send <= background;
        if (state_d2 == rd0)
            pixel_send <= updating_pixel;
    end
    
endmodule