`timescale 1ns / 1ps
module gpu
#(
    parameter ram_add_width = 8,
    parameter NR_OF_BLOBS = 4
)
(
    input clk,  // system clock   
    input reset,
    
    // background color
    input logic [11:0] background,
    
    // blobs' settings:
    // enable sprite  (show it on screen)
    input logic sprite_enable [NR_OF_BLOBS-1:0],    
    // position on the screen (y - vertical, x - horizontal)
    input logic [9:0] y1_pos [NR_OF_BLOBS-1:0],
    input logic [9:0] x1_pos [NR_OF_BLOBS-1:0],
    input logic [9:0] height [NR_OF_BLOBS-1:0],
    input logic [9:0] width [NR_OF_BLOBS-1:0],
    // start address in RAM, TBD MSBs are nr of BRAM
    input logic [ram_add_width-1:0] ram_address [NR_OF_BLOBS-1:0],
    input logic [1:0]  layer [NR_OF_BLOBS-1:0],
    
    // BRAM write ports
    input logic [ram_add_width-1:0]  wr_add,
    input logic [11:0] wr_data,
    input logic        wr_req,
    
    // //////////////////////////////////////
    // // for simulation purposes only!!!
    // output logic [9:0]curr_x_pos_delayed,
    // output logic [9:0]curr_y_pos_delayed,
    // ////////////////////////////////////
    
    
    // output ports to VGA
    // pixel
    output logic [11:0] pixel_send,
    // horizontal/vertical sync
    output logic v_sync,
    output logic h_sync
);

    // internal nets
    logic [1:0] blob_layer [NR_OF_BLOBS-1:0];
    logic en25M;
    logic [ram_add_width-1:0] requested_add [NR_OF_BLOBS-1:0];
    logic [NR_OF_BLOBS-1:0] request;
    wire [9:0] curr_y_pos;
    wire [9:0] curr_x_pos;
    wire h_sync_mod;
    wire v_sync_mod;
    wire blank;
    wire [11:0] pixel_from_arbiter;
    wire blank_delayed;
    
    genvar i;
    generate
        for (i=0; i<NR_OF_BLOBS; i++) begin : genblob
            blob #(.ram_add_width(ram_add_width))
            blob0 (
                .clk              (clk              ),
                .clk25en          (en25M            ),
                .sprite_enable    (sprite_enable[i] ),
                .y1_pos           (y1_pos       [i] ),
                .x1_pos           (x1_pos       [i] ),
                .height           (height       [i] ),
                .width            (width       [i] ),
                .address_in       (ram_address  [i] ),
                .layer_in         (layer        [i] ),
                .layer_out        (blob_layer   [i] ), 
                .address_out      (requested_add[i] ),  
                .request          (request      [i] ),
                .curr_y_pos       (curr_y_pos       ), 
                .curr_x_pos       (curr_x_pos       ), 
                .blank            (blank            )   
            ); 
        end
    endgenerate
    
    pixel_arbiter
    #(  
        .ADD_WIDTH(ram_add_width),
        .NR_OF_BLOBS(NR_OF_BLOBS),
        .NR_OF_RAMS (1)
    ) pixel_arbiter_i
    (
        .clk                                (clk),  
        .reset                              (reset),
        .background                         (background),
        .layer                              (blob_layer),        
        .address                            (requested_add),      
        .request                            (request),         
        .wr_add                             (wr_add ),
        .wr_data                            (wr_data),
        .wr_req                             (wr_req ),
        .pixel_send                         (pixel_from_arbiter)
    );

    sync_mod sync_mod_i(
        .clk(clk),
        .reset(reset),
        .EN25(en25M),
        .Y_POS(curr_y_pos),
        .X_POS(curr_x_pos),
        .H_SYNC(h_sync_mod),
        .V_SYNC(v_sync_mod),
        .BLANK(blank)       
    );
    
    delay #(
        .delay_length(13),
        .data_width(1)
    ) delay_v_sync
    (
        .clk        (clk),
        .data_in    (v_sync_mod),
        .data_out   (v_sync)
    );
    
    delay #(
        .delay_length(13),
        .data_width(1)
    ) delay_h_sync
    (
        .clk        (clk),
        .data_in    (h_sync_mod),
        .data_out   (h_sync)
    );    

    delay #(
        .delay_length(13),
        .data_width(1)
    ) delay_blank
    (
        .clk        (clk),
        .data_in    (blank),
        .data_out   (blank_delayed)
    );  
    
    assign pixel_send = (blank_delayed) ? 12'h000 : pixel_from_arbiter;
    
    // ////////////////////////////////////
    // // for simulation purposes only!!!
    // delay #(
        // .delay_length(13),
        // .data_width(10)
    // ) delay_x_curr
    // (
        // .clk        (clk),
        // .data_in    (curr_x_pos),
        // .data_out   (curr_x_pos_delayed)
    // );    
    // delay #(
        // .delay_length(13),
        // .data_width(10)
    // ) delay_y_curr
    // (
        // .clk        (clk),
        // .data_in    (curr_y_pos),
        // .data_out   (curr_y_pos_delayed)
    // ); 
    // ////////////////////////////////////
    
endmodule