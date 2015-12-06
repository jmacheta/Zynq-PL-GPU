// This module maps SystemVerilog unpacked ports to AXI registers 
`timescale 1ns / 1ps                        
module gpu_wrapper                          
#(                                          
    parameter ram_add_width = 16,           
    parameter NR_OF_BLOBS = 4              
)                                           
(                                           
    input clk,  // system clock             
    input reset,                            

    // AXI slave registers:
    input wire [31:0] slv_reg0,                             
    input wire [31:0] slv_reg1,                             
    input wire [31:0] slv_reg2,                             
    input wire [31:0] slv_reg3,                             
    input wire [31:0] slv_reg4,                             
    input wire [31:0] slv_reg5,                             
    input wire [31:0] slv_reg6,                             
    input wire [31:0] slv_reg7,                             
    input wire [31:0] slv_reg8,                             
    input wire [31:0] slv_reg9,                             
    input wire [31:0] slv_reg10,                             
    input wire [31:0] slv_reg11,                             
    input wire [31:0] slv_reg12,                             
    input wire [31:0] slv_reg13,                             
    input wire [31:0] slv_reg14,                             
    input wire [31:0] slv_reg15,                             

    // BRAM write port                                      
    input wire        wr_req,                               

    // output ports to VGA                                  
    // pixel                                                
    output wire [11:0] pixel_send,                          
    // horizontal/vertical sync                             
    output wire v_sync,                                     
    output wire h_sync                                      
);                                                          

    logic sprite_enable [NR_OF_BLOBS-1:0];                  
    logic [9:0] y1_pos  [NR_OF_BLOBS-1:0];                  
    logic [9:0] x1_pos  [NR_OF_BLOBS-1:0];                  
    logic [9:0] y2_pos  [NR_OF_BLOBS-1:0];                  
    logic [9:0] x2_pos  [NR_OF_BLOBS-1:0];                  
    logic [ram_add_width-1:0] ram_address [NR_OF_BLOBS-1:0];
    logic [1:0]  layer [NR_OF_BLOBS-1:0];                   
    logic [11:0] background;                                
    logic [ram_add_width-1:0]  wr_add;                 
    logic [11:0] wr_data;                              

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
    
    // Map slave registers to GPU IOs
    
    // background color                     
    assign background = slv_reg0;           
    assign wr_add     = slv_reg1;           
    assign wr_data    = slv_reg2;           
    
    // BLOB0                                   
    assign  sprite_enable[0] = slv_reg3[0];
    assign         y1_pos[0] = slv_reg4[9:0];
    assign         x1_pos[0] = slv_reg4[19:10];
    assign         y2_pos[0] = slv_reg4[29:20];
    assign         x2_pos[0] = slv_reg5[9:0];
    assign          layer[0] = slv_reg5[11:10];
    assign    ram_address[0] = slv_reg6[ram_add_width-1:0];

    // BLOB1                                   
    assign  sprite_enable[1] = slv_reg3[1];
    assign         y1_pos[1] = slv_reg7[9:0];
    assign         x1_pos[1] = slv_reg7[19:10];
    assign         y2_pos[1] = slv_reg7[29:20];
    assign         x2_pos[1] = slv_reg8[9:0];
    assign          layer[1] = slv_reg8[11:10];
    assign    ram_address[1] = slv_reg9[ram_add_width-1:0];

    // BLOB2                                   
    assign  sprite_enable[2] = slv_reg3[2];
    assign         y1_pos[2] = slv_reg10[9:0];
    assign         x1_pos[2] = slv_reg10[19:10];
    assign         y2_pos[2] = slv_reg10[29:20];
    assign         x2_pos[2] = slv_reg11[9:0];
    assign          layer[2] = slv_reg11[11:10];
    assign    ram_address[2] = slv_reg12[ram_add_width-1:0];

    // BLOB3                                   
    assign  sprite_enable[3] = slv_reg3[3];
    assign         y1_pos[3] = slv_reg13[9:0];
    assign         x1_pos[3] = slv_reg13[19:10];
    assign         y2_pos[3] = slv_reg13[29:20];
    assign         x2_pos[3] = slv_reg14[9:0];
    assign          layer[3] = slv_reg14[11:10];
    assign    ram_address[3] = slv_reg15[ram_add_width-1:0];

endmodule
