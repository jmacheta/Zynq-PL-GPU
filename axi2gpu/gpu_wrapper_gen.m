% HOW TU USE
% set nr of blobs and RAM address width
% run script which generates 2 files:
% -gpu_wrapper.sv - add this file to project
% -gpu_wrapper_inst.sv - add this code to axi2gpu_v1_0_S00_AXI.v between "// Add user logic here" and "// User logic ends"
%
% Registers description (name, bits, description):
% GENERAL
% register0
%      11:0 - background
%
% RAM MEMORY
% register1
%      ram_add_width-1:0   write address   
% register2
%      11:0    write data
%
% register3
%      nr_of_blobs:0 - enable sprite (all sprites in one register)
%
% BLOB x
% register x*3 + 4
%      9:0     y1_pos
%      19:10   x1_pos
%      29:20   y2_pos
% register x*3 + 5
%      9:0     x2_pos
%      11:10   layer
% register x*3 + 6
%      ram_add_width-1:0   start address in memory
%
nr_of_blobs = 4;
ram_add_width = 16;

offset = 4;
nr_of_regs = 3*nr_of_blobs + offset;
fileID = fopen('gpu_wrapper.sv','w');
fprintf(fileID,'// This module maps SystemVerilog unpacked ports to AXI registers \n');
fprintf(fileID,'`timescale 1ns / 1ps                        \n');
fprintf(fileID,'module gpu_wrapper                          \n');
fprintf(fileID,'#(                                          \n');
fprintf(fileID,'    parameter ram_add_width = %d,           \n',ram_add_width);
fprintf(fileID,'    parameter NR_OF_BLOBS = %d              \n',nr_of_blobs);
fprintf(fileID,')                                           \n');
fprintf(fileID,'(                                           \n');
fprintf(fileID,'    input clk,  // system clock             \n');
fprintf(fileID,'    input reset,                            \n');
fprintf(fileID,'\n');
fprintf(fileID,'    // AXI slave registers:\n');
for i=0:1:nr_of_regs-1
fprintf(fileID,'    input wire [31:0] slv_reg%d,                             \n',i);
end
fprintf(fileID,'\n');
fprintf(fileID,'    // BRAM write port                                      \n');
fprintf(fileID,'    input wire        wr_req,                               \n');
fprintf(fileID,'\n');
fprintf(fileID,'    // output ports to VGA                                  \n');
fprintf(fileID,'    // pixel                                                \n');
fprintf(fileID,'    output wire [11:0] pixel_send,                          \n');
fprintf(fileID,'    // horizontal/vertical sync                             \n');
fprintf(fileID,'    output wire v_sync,                                     \n');
fprintf(fileID,'    output wire h_sync                                      \n');
fprintf(fileID,');                                                          \n');
fprintf(fileID,'\n');
fprintf(fileID,'    logic sprite_enable [NR_OF_BLOBS-1:0];                  \n');
fprintf(fileID,'    logic [9:0] y1_pos  [NR_OF_BLOBS-1:0];                  \n');
fprintf(fileID,'    logic [9:0] x1_pos  [NR_OF_BLOBS-1:0];                  \n');
fprintf(fileID,'    logic [9:0] y2_pos  [NR_OF_BLOBS-1:0];                  \n');
fprintf(fileID,'    logic [9:0] x2_pos  [NR_OF_BLOBS-1:0];                  \n');
fprintf(fileID,'    logic [ram_add_width-1:0] ram_address [NR_OF_BLOBS-1:0];\n');
fprintf(fileID,'    logic [1:0]  layer [NR_OF_BLOBS-1:0];                   \n');
fprintf(fileID,'    logic [11:0] background;                                \n');
fprintf(fileID,'    logic [ram_add_width-1:0]  wr_add;                 \n');
fprintf(fileID,'    logic [11:0] wr_data;                              \n');
fprintf(fileID,'\n');
fprintf(fileID,'    gpu #(                                                  \n');
fprintf(fileID,'        .ram_add_width (ram_add_width),                     \n');
fprintf(fileID,'        .NR_OF_BLOBS   (NR_OF_BLOBS  )                      \n');
fprintf(fileID,'    ) gpu_i                                                 \n');
fprintf(fileID,'    (                                                       \n');
fprintf(fileID,'        .clk              (clk          ),                  \n');
fprintf(fileID,'        .reset            (reset        ),                  \n');
fprintf(fileID,'        .background       (background   ),                  \n');
fprintf(fileID,'        .sprite_enable    (sprite_enable),                  \n');
fprintf(fileID,'        .y1_pos           (y1_pos       ),                  \n');
fprintf(fileID,'        .x1_pos           (x1_pos       ),                  \n');
fprintf(fileID,'        .y2_pos           (y2_pos       ),                  \n');
fprintf(fileID,'        .x2_pos           (x2_pos       ),                  \n');
fprintf(fileID,'        .ram_address      (ram_address  ),                  \n');
fprintf(fileID,'        .layer            (layer        ),                  \n');
fprintf(fileID,'        .wr_add           (wr_add       ),                  \n');
fprintf(fileID,'        .wr_data          (wr_data      ),                  \n');
fprintf(fileID,'        .wr_req           (wr_req       ),                  \n');
fprintf(fileID,'        .pixel_send       (pixel_send   ),                  \n');
fprintf(fileID,'        .v_sync           (v_sync       ),                  \n');
fprintf(fileID,'        .h_sync           (h_sync       )                   \n');
fprintf(fileID,'    );                                                      \n');
fprintf(fileID,'    \n');
fprintf(fileID,'    // Map slave registers to GPU IOs\n');
fprintf(fileID,'    \n');
fprintf(fileID,'    // background color                     \n');
fprintf(fileID,'    assign background = slv_reg0;           \n');
fprintf(fileID,'    assign wr_add     = slv_reg1;           \n');
fprintf(fileID,'    assign wr_data    = slv_reg2;           \n');
fprintf(fileID,'    \n');
for i=0:1:nr_of_blobs-1
fprintf(fileID,'    // BLOB%d                                   \n',i);
fprintf(fileID,'    assign  sprite_enable[%d] = slv_reg3[%d];\n'                ,i,i);
fprintf(fileID,'    assign         y1_pos[%d] = slv_reg%d[9:0];\n'              ,i,3*i+offset);
fprintf(fileID,'    assign         x1_pos[%d] = slv_reg%d[19:10];\n'            ,i,3*i+offset);
fprintf(fileID,'    assign         y2_pos[%d] = slv_reg%d[29:20];\n'            ,i,3*i+offset);
fprintf(fileID,'    assign         x2_pos[%d] = slv_reg%d[9:0];\n'              ,i,3*i+offset+1);
fprintf(fileID,'    assign          layer[%d] = slv_reg%d[11:10];\n'            ,i,3*i+offset+1);
fprintf(fileID,'    assign    ram_address[%d] = slv_reg%d[ram_add_width-1:0];\n',i,3*i+offset+2);
fprintf(fileID,'\n');
end
fprintf(fileID,'endmodule\n');

% example instantation
fileID = fopen('gpu_wrapper_inst.sv','w');
fprintf(fileID,'    localparam ram_add_width = %d;\n',ram_add_width);
fprintf(fileID,'    wire wr_req =  (slv_reg_wren) & (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]== 5''h2);\n');
fprintf(fileID,'    \n');
fprintf(fileID,'    gpu_wrapper #(                                             \n');
fprintf(fileID,'            .ram_add_width (ram_add_width),                    \n');
fprintf(fileID,'            .NR_OF_BLOBS   (%d)                                \n',nr_of_blobs);
fprintf(fileID,'        ) gpu_wrapper_i                                        \n');
fprintf(fileID,'        (                                                      \n');
fprintf(fileID,'            .clk              (S_AXI_ACLK    ), \n');
fprintf(fileID,'            .reset            (!S_AXI_ARESETN), \n');
for i=0:1:nr_of_regs-1
fprintf(fileID,'            .slv_reg%d        (slv_reg%d     ), \n',i,i);
end
fprintf(fileID,'            .wr_req           (wr_req        ),\n');
fprintf(fileID,'            .pixel_send       (pixel_send    ),\n');
fprintf(fileID,'            .v_sync           (v_sync        ),\n');
fprintf(fileID,'            .h_sync           (h_sync        ) \n');
fprintf(fileID,'        );\n');
    