`timescale 1ns / 1ps
module blob
#(       
    parameter ram_add_width = 8
) 
(
    // system inputs
    input clk,  // system clock 100MHz
    input clk25en,  // clock enable for 25MHz operations
    // no reset - registers shall be reset at the connection to AXI
    
    // control registers
    // enable sprite  (show it on screen)
    input sprite_enable,    
    // postion on the screen (y - vertical, x - horizontal)
    input [9:0] y1_pos,
    input [9:0] x1_pos,
    // width and height of sprite
    input [9:0] height,
    input [9:0] width,
    // start address in RAM, TBD MSBs are nr of BRAM
    input  [ram_add_width-1:0] address_in,
    // TBD: some other control registers, like turn clockwise etc.
    
    // data send direclty from registers to pixel arbiter
    // layer 
    input  [1:0]  layer_in,
    output [1:0]  layer_out,

    // data send to pixel arbiter
    // address of currently requested pixel
    output [ram_add_width-1:0] address_out,
    
    // request send to pixel arbiter (40 ns pulse)
    output reg request,
    
    // current position on the screen
    input [9:0] curr_y_pos,
    input [9:0] curr_x_pos,
    // video is on when BLANK is 0
    input blank
        
);
    
    //latch layer, address and sprite position values
    //when current position is 0,0
    // (to avoid unstable situations)
    reg [1:0]                   layer_latched;
    reg [ram_add_width-1:0]     address_latched;
    reg [9:0]                   y1_pos_latched;
    reg [9:0]                   x1_pos_latched;
    reg [9:0]                   y2_pos_latched;
    reg [9:0]                   x2_pos_latched;
    reg [9:0]                   y2_pos_offset_latched;
    reg [9:0]                   x2_pos_offset_latched;
    
    always @(posedge clk) begin 
        if ((curr_y_pos == 0) && (curr_x_pos == 0)) begin
            layer_latched <= layer_in;
            address_latched <= address_in;
            y1_pos_latched <= y1_pos;
            x1_pos_latched <= x1_pos;
            if ( y1_pos >= height - 1) begin
                y2_pos_latched <= y1_pos + 1 - height;
                y2_pos_offset_latched <= 0;
            end else begin
                y2_pos_latched <= 0;
                y2_pos_offset_latched <= height - y1_pos - 1;
            end
            if ( x1_pos >= width -1) begin
                x2_pos_latched <= x1_pos + 1 - width;
                x2_pos_offset_latched <= 0;
            end else begin
                x2_pos_latched <= 0;
                x2_pos_offset_latched <= width - x1_pos - 1;
            end
        end
    end
    
    // position detection - current location is within sprite location
    reg position_cond;
    
    // vertical condition
    wire y_cond = (curr_y_pos <= y1_pos_latched) && (curr_y_pos >= y2_pos_latched);
    // horizontal condition
    wire x_cond = (curr_x_pos <= x1_pos_latched) && (curr_x_pos >= x2_pos_latched);

    always @(posedge clk) begin
        position_cond <=  x_cond && y_cond && !blank;
    end
    
    // request generation (to pixel arbiter)
    always @(posedge clk) begin 
        if (sprite_enable && position_cond && clk25en)  // generate 1 request per 4 cc of pixel time
            request <= 1;
        else
            request <= 0;
    end
    
     // address of current pixel - set to start address when current position is 0,0,
     // increment when request condition occurs
//     reg [ram_add_width-1:0] address_out_reg;
//     always @(posedge clk) begin 
//         if ((curr_y_pos == 0) && (curr_x_pos == 0))
//             address_out_reg <= address_latched;
//         else if (request)
//             address_out_reg <= address_latched + ((curr_y_pos - y2_pos_latched) * width) + (curr_x_pos - x2_pos_latched);
//     end
     
    // layer and address to pixel arbiter
    assign layer_out = layer_latched;
    assign address_out = address_latched + ((curr_y_pos - y2_pos_latched + y2_pos_offset_latched) * width) + (curr_x_pos - x2_pos_latched + x2_pos_offset_latched);
    
endmodule