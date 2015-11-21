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
    output [11:0] pixel_send
    
);
    
    int i;
    
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
    
    // delay 1 clock cycle - TBD in future collission detection
    always @(posedge clk) begin
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
    
    // capture address of pixels for all layers
    logic [ADD_WIDTH-1:0] layer0_add;  //TBD for all - add length
    logic [ADD_WIDTH-1:0] layer1_add;
    logic [ADD_WIDTH-1:0] layer2_add;
    logic [ADD_WIDTH-1:0] layer3_add;
    // delayed values of requests
    // logic layer_req_d0[3:0] = {0,0,0,0}; //TBD
    
    // delay 2 clock cycles
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
    
    logic [ADD_WIDTH-1:0] rd_add;
    always @(*) begin
        case (state)
        rd3 : rd_add <= layer3_add;
        rd2 : rd_add <= layer2_add;
        rd1 : rd_add <= layer1_add;
        rd0 : rd_add <= layer0_add;
        default : rd_add <= 0;
        endcase
    end
    
    // TBD:
    // reg [11:0] updating_pixel;
    // reg state_d0;
    // always @(posedge clk) begin
        // if (reset)
            // state_d0 <= init;
        // else begin
            // state_d0 <= state;
        // case (state_d0)
            // rd3 : 
            // rd2 : 
            // rd1 : 
            // rd0 : 
            // default : rd_add <= 0;
        // endcase
        // updating_pixel <= rd_data;
    // end
    // end
    
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
    
endmodule