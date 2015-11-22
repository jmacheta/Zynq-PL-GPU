
`timescale 1ns / 1ps


module blob_tb();

    localparam NR_OF_BLOBS = 4;
    localparam ram_add_width = 16;
    reg clk;  // system clock   
    reg en25 = 0;
    // control registers
    // enable sprite  (show it on screen)
    reg sprite_enable[NR_OF_BLOBS-1:0];    
    // postion on the screen (y - vertical, x - horizontal)
    reg [9:0] y1_pos[NR_OF_BLOBS-1:0];
    reg [9:0] x1_pos[NR_OF_BLOBS-1:0];
    reg [9:0] y2_pos[NR_OF_BLOBS-1:0];
    reg [9:0] x2_pos[NR_OF_BLOBS-1:0];
    // start address in RAM, TBD MSBs are nr of BRAM
    reg  [ram_add_width-1:0] address_in[NR_OF_BLOBS-1:0]; //TBD length
    // data send direclty from registers to pixel arbiter
    // layer 
    reg  [1:0]  layer_in[NR_OF_BLOBS-1:0];
    wire [1:0]  layer_out[NR_OF_BLOBS-1:0];
    // data send to pixel arbiter
    // address of currently requested pixel TBD!!!
    wire [ram_add_width-1:0] address_out[NR_OF_BLOBS-1:0];
    //NOTE: length can be calculated using x1/x2/y1/y2
    // request send to pixel arbiter (1 cc of MHz pulse)
    wire [NR_OF_BLOBS-1:0]request;
    // current position on the screen
    reg [9:0] curr_y_pos = 0;
    reg [9:0] curr_x_pos = 0;
    // video is on
    reg blank;
    
    // PIXEL ARBITER
    reg reset;
    reg [11:0] background = 12'habc;
    // reg [1:0] layer [NR_OF_BLOBS-1:0];
    // reg [ADD_WIDTH-1:0] address [NR_OF_BLOBS-1:0];
    // reg [NR_OF_BLOBS-1:0] request;
    reg [ram_add_width-1:0]  wr_add;
    reg [11:0] wr_data;
    reg        wr_req;
    wire  [11:0] pixel_send;    // output
    
    
    // // sync mod
    // reg reset;
    // wire ce25meg;
    // wire h_sync;
    // wire v_sync;
    
    // Instantiate the Unit Under Test (UUT)
    
    // TBD: generate?
    blob #(.ram_add_width(ram_add_width))
    blob0 (
        .clk              (clk          ),
        .clk25en          (en25         ),
        .sprite_enable    (sprite_enable[0]),
        .y1_pos           (y1_pos[0]       ),
        .x1_pos           (x1_pos[0]       ),
        .y2_pos           (y2_pos[0]       ),
        .x2_pos           (x2_pos[0]       ),
        .address_in       ( address_in[0]  ),
        .layer_in         ( layer_in[0]    ),
        .layer_out        (layer_out[0]    ),
        .address_out      (address_out[0]  ),
        .request          (request[0]      ),
        .curr_y_pos       (curr_y_pos   ),
        .curr_x_pos       (curr_x_pos   ),
        .blank            (blank        )
    );   
    blob #(.ram_add_width(ram_add_width))
    blob1 (
        .clk              (clk          ),
        .clk25en          (en25         ),
        .sprite_enable    (sprite_enable[1]),
        .y1_pos           (y1_pos[1]       ),
        .x1_pos           (x1_pos[1]       ),
        .y2_pos           (y2_pos[1]       ),
        .x2_pos           (x2_pos[1]       ),
        .address_in       ( address_in[1]  ),
        .layer_in         ( layer_in[1]    ),
        .layer_out        (layer_out[1]    ),
        .address_out      (address_out[1]  ),
        .request          (request[1]      ),
        .curr_y_pos       (curr_y_pos   ),
        .curr_x_pos       (curr_x_pos   ),
        .blank            (blank        )
    ); 
    blob #(.ram_add_width(ram_add_width))
    blob2 (
        .clk              (clk          ),
        .clk25en          (en25         ),
        .sprite_enable    (sprite_enable[2]),
        .y1_pos           (y1_pos[2]       ),
        .x1_pos           (x1_pos[2]       ),
        .y2_pos           (y2_pos[2]       ),
        .x2_pos           (x2_pos[2]       ),
        .address_in       ( address_in[2]  ),
        .layer_in         ( layer_in[2]    ),
        .layer_out        (layer_out[2]    ),
        .address_out      (address_out[2]  ),
        .request          (request[2]      ),
        .curr_y_pos       (curr_y_pos   ),
        .curr_x_pos       (curr_x_pos   ),
        .blank            (blank        )
    ); 
    
    blob #(.ram_add_width(ram_add_width))
    blob3 (
        .clk              (clk          ),
        .clk25en          (en25         ),
        .sprite_enable    (sprite_enable[3]),
        .y1_pos           (y1_pos[3]       ),
        .x1_pos           (x1_pos[3]       ),
        .y2_pos           (y2_pos[3]       ),
        .x2_pos           (x2_pos[3]       ),
        .address_in       ( address_in[3]  ),
        .layer_in         ( layer_in[3]    ),
        .layer_out        (layer_out[3]    ),
        .address_out      (address_out[3]  ),
        .request          (request[3]      ),
        .curr_y_pos       (curr_y_pos   ),
        .curr_x_pos       (curr_x_pos   ),
        .blank            (blank        )
    );     
    
    pixel_arbiter
#(  
    .ADD_WIDTH  (ram_add_width),
    .NR_OF_BLOBS(NR_OF_BLOBS),
    .NR_OF_RAMS (1)
) pixel_arbiter_i
(
    .clk                                (clk),  
    .reset                              (reset),
    .background                         (background),
    .layer                              (layer_out),
    .address                            (address_out),
    .request                            (request),
    .wr_add                             (wr_add ),
    .wr_data                            (wr_data),
    .wr_req                             (wr_req ),
    .pixel_send                         (pixel_send)    // output
        
);

    
    // sync_mod sync_mod_i(
        // .clk(clk),
        // .reset(reset),
        // .Y_POS(curr_y_pos),
        // .X_POS(curr_x_pos),
        // .H_SYNC(h_sync),
        // .V_SYNC(v_sync),
        // .BLANK(blank)
    // );


    parameter clk_period = 10;
    parameter clk_half_period = 5;
    
    initial begin
        reset = 1;
        clk = 1;
        blank = 0;
        wr_req = 0;
        
        sprite_enable[0] = 0;
        layer_in[0] = 3;
        x1_pos[0] <= 3;
        y1_pos[0] <= 5;
        x2_pos[0] <= 6;
        y2_pos[0] <= 7;
        address_in[0] <= 50;

        sprite_enable[1] = 0;
        layer_in[1] = 2;
        x1_pos[1] <= 3;
        y1_pos[1] <= 5;
        x2_pos[1] <= 6;
        y2_pos[1] <= 7;
        address_in[1] <= 1;

        sprite_enable[2] = 0;
        layer_in[2] = 1;
        x1_pos[2] <= 3;
        y1_pos[2] <= 5;
        x2_pos[2] <= 6;
        y2_pos[2] <= 7;
        address_in[2] <= 100;

        sprite_enable[3] = 0;
        layer_in[3] = 0;
        x1_pos[3] <= 3;
        y1_pos[3] <= 5;
        x2_pos[3] <= 6;
        y2_pos[3] <= 7;
        address_in[3] <= 150;
        
        #(5*clk_period);
        reset = 0;
        

        #(2*clk_period);
        sprite_enable[0] = 1;
        sprite_enable[1] = 0;
        sprite_enable[2] = 1;
        sprite_enable[3] = 1;
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

