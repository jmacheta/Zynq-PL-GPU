
`timescale 1ns / 1ps


module blob_tb();

    
    reg clk;  // system clock   
    reg en25 = 0;
    // control registers
    // enable sprite  (show it on screen)
    reg sprite_enable;    
    // postion on the screen (y - vertical, x - horizontal)
    reg [9:0] y1_pos;
    reg [9:0] x1_pos;
    reg [9:0] y2_pos;
    reg [9:0] x2_pos;
    // start address in RAM, TBD MSBs are nr of BRAM
    reg  [15:0] address_in; //TBD length
    // data send direclty from registers to pixel arbiter
    // layer 
    reg  [1:0]  layer_in;
    wire [1:0]  layer_out;
    // data send to pixel arbiter
    // address of currently requested pixel TBD!!!
    wire [15:0] address_out;
    //NOTE: length can be calculated using x1/x2/y1/y2
    // request send to pixel arbiter (1 cc of MHz pulse)
    wire request;
    // current position on the screen
    reg [9:0] curr_y_pos = 0;
    reg [9:0] curr_x_pos = 0;
    // video is on
    reg blank;
    
    // // sync mod
    // reg reset;
    // wire ce25meg;
    // wire h_sync;
    // wire v_sync;
    
    // Instantiate the Unit Under Test (UUT)
    blob uut (
        .clk              (clk          ),
        .clk25en    (en25         ),
        .sprite_enable    (sprite_enable),
        .y1_pos           (y1_pos       ),
        .x1_pos           (x1_pos       ),
        .y2_pos           (y2_pos       ),
        .x2_pos           (x2_pos       ),
        .address_in       ( address_in  ),
        .layer_in         ( layer_in    ),
        .layer_out        (layer_out    ),
        .address_out      (address_out  ),
        .request          (request      ),
        .curr_y_pos       (curr_y_pos   ),
        .curr_x_pos       (curr_x_pos   ),
        .blank            (blank        )
    );   
    
    // sync_mod sync_mod_i(
        // .clk(clk),
        // .reset(reset),
        // .EN(ce25meg),
        // .Y_POS(curr_y_pos),
        // .X_POS(curr_x_pos),
        // .H_SYNC(h_sync),
        // .V_SYNC(v_sync),
        // .BLANK(blank)
    // );
    
    // Prescaler Prescaler_i(
        // .clk(clk),
        // .clr(reset),
        // .CE(1'b1),
        // .CEO(ce25meg)
    // );
    
    
    parameter clk_period = 10;
    parameter clk_half_period = 5;
    
    initial begin
        // reset = 1;
        clk = 1;
        blank = 0;
        sprite_enable = 0;
        layer_in = 3;
        x1_pos <= 3;
        y1_pos <= 5;
        x2_pos <= 6;
        y2_pos <= 7;
        address_in <= 1;
        // address_in = TBD
        #(5*clk_period);
        // reset = 0;
        

        #(clk_period);
        sprite_enable = 1;
        #(2*2*2*10*2048*clk_period);
        $stop;


    end
    
    always
        #clk_half_period clk = !clk;
    
    // 25MHz prescaler
    reg [1:0] cnt4bit = 0;
    always @(posedge clk) begin
        cnt4bit = cnt4bit + 1;
        if (cnt4bit == 3)
            en25 <= 1;
        else
            en25 <= 0;
    end
    
    // current positions generators
    always @(posedge clk) begin
        if (en25)
            if (curr_x_pos == 640-1)
                curr_x_pos <= 0;
            else
                curr_x_pos <= curr_x_pos+1;
    end
    always @(posedge clk) begin
        if ((curr_x_pos == 640-1) & en25) 
            if (curr_y_pos == 30-1)    //480 - set to 30 for simulation purposes
                curr_y_pos <= 0;
            else
                curr_y_pos <= curr_y_pos+1;
    end
     
endmodule

