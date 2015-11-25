`timescale 1ns / 1ps
module gpu_wrapper
#(
    parameter ram_add_width = 8,
    parameter NR_OF_BLOBS = 4
)
(
    input clk,  // system clock   
    input reset,
    
    // background color
    input wire [11:0] background,
    
    // blobs' settings:
    
    // BLOB0
    // enable sprite  (show it on screen)
    input wire sprite_enable0,    
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos0,
    input wire [9:0] x1_pos0,
    input wire [9:0] y2_pos0,
    input wire [9:0] x2_pos0,
    // start address in RAM, TBD MSBs are nr of BRAM
    input wire [ram_add_width-1:0] ram_address0,
    input wire [1:0]  layer0,
    
    // BLOB1
    // enable sprite  (show it on screen)
    input wire sprite_enable1,    
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos1,
    input wire [9:0] x1_pos1,
    input wire [9:0] y2_pos1,
    input wire [9:0] x2_pos1,
    // start address in RAM, TBD MSBs are nr of BRAM
    input wire [ram_add_width-1:0] ram_address1,
    input wire [1:0]  layer1,
    
    
    // BLOB2
    // enable sprite  (show it on screen)
    input wire sprite_enable2,    
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos2,
    input wire [9:0] x1_pos2,
    input wire [9:0] y2_pos2,
    input wire [9:0] x2_pos2,
    // start address in RAM, TBD MSBs are nr of BRAM
    input wire [ram_add_width-1:0] ram_address2,
    input wire [1:0]  layer2,
    
    // BLOB3
    // enable sprite  (show it on screen)
    input wire sprite_enable3,    
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos3,
    input wire [9:0] x1_pos3,
    input wire [9:0] y2_pos3,
    input wire [9:0] x2_pos3,
    // start address in RAM, TBD MSBs are nr of BRAM
    input wire [ram_add_width-1:0] ram_address3,
    input wire [1:0]  layer3,
    
    // BRAM write ports
    input wire [ram_add_width-1:0]  wr_add,
    input wire [11:0] wr_data,
    input wire        wr_req,
    
    // output ports to VGA
    // pixel
    output wire [11:0] pixel_send,
    // horizontal/vertical sync
    output wire v_sync,
    output wire h_sync
);

    logic sprite_enable [NR_OF_BLOBS-1:0];    
    logic [9:0] y1_pos [NR_OF_BLOBS-1:0];
    logic [9:0] x1_pos [NR_OF_BLOBS-1:0];
    logic [9:0] y2_pos [NR_OF_BLOBS-1:0];
    logic [9:0] x2_pos [NR_OF_BLOBS-1:0];
    logic [ram_add_width-1:0] ram_address [NR_OF_BLOBS-1:0];
    logic [1:0]  layer [NR_OF_BLOBS-1:0];
    
    gpu #(
        .ram_add_width (ram_add_width),
        .NR_OF_BLOBS   (NR_OF_BLOBS  )
    ) gpu_i
    (
        .clk              (clk          ),
        .reset            (reset        ),
        .background       (background   ),
        .sprite_enable    (sprite_enable),
        .y1_pos           (y1_pos       ),
        .x1_pos           (x1_pos       ),
        .y2_pos           (y2_pos       ),
        .x2_pos           (x2_pos       ),
        .ram_address      (ram_address  ),
        .layer            (layer        ),
        .wr_add           (wr_add       ),
        .wr_data          (wr_data      ),
        .wr_req           (wr_req       ),
        .pixel_send       (pixel_send   ),
        .v_sync           (v_sync       ),
        .h_sync           (h_sync       )
    );
    
    
    // BLOB0
    assign  sprite_enable[0] = sprite_enable0;
    assign         y1_pos[0] =        y1_pos0;
    assign         x1_pos[0] =        x1_pos0;
    assign         y2_pos[0] =        y2_pos0;
    assign         x2_pos[0] =        x2_pos0;
    assign    ram_address[0] =   ram_address0;
    assign          layer[0] =         layer0;
    
    // BLOB1                  
    assign  sprite_enable[1] = sprite_enable1;
    assign         y1_pos[1] =        y1_pos1;
    assign         x1_pos[1] =        x1_pos1;
    assign         y2_pos[1] =        y2_pos1;
    assign         x2_pos[1] =        x2_pos1;
    assign    ram_address[1] =   ram_address1;
    assign          layer[1] =         layer1;
    
    // BLOB2                  
    assign  sprite_enable[2] = sprite_enable2;
    assign         y1_pos[2] =        y1_pos2;
    assign         x1_pos[2] =        x1_pos2;
    assign         y2_pos[2] =        y2_pos2;
    assign         x2_pos[2] =        x2_pos2;
    assign    ram_address[2] =   ram_address2;
    assign          layer[2] =         layer2;
    
    // BLOB3                  
    assign  sprite_enable[3] = sprite_enable3;
    assign         y1_pos[3] =        y1_pos3;
    assign         x1_pos[3] =        x1_pos3;
    assign         y2_pos[3] =        y2_pos3;
    assign         x2_pos[3] =        x2_pos3;
    assign    ram_address[3] =   ram_address3;
    assign          layer[3] =         layer3;   
    
endmodule