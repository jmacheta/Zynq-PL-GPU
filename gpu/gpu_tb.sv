module gpu_tb
#(
    parameter ram_add_width = 8,
    parameter NR_OF_BLOBS = 4
)();

    // GPU IOs
    // inputs
    logic clk;
    logic reset;
    logic [11:0] background;
    logic sprite_enable [NR_OF_BLOBS-1:0];    
    logic [9:0] y1_pos [NR_OF_BLOBS-1:0];
    logic [9:0] x1_pos [NR_OF_BLOBS-1:0];
    logic [9:0] y2_pos [NR_OF_BLOBS-1:0];
    logic [9:0] x2_pos [NR_OF_BLOBS-1:0];
    logic [ram_add_width-1:0] ram_address [NR_OF_BLOBS-1:0];
    logic [1:0]  layer [NR_OF_BLOBS-1:0];
    logic [ram_add_width-1:0]  wr_add;
    logic [11:0] wr_data;
    logic        wr_req;
    // outputs
    logic [11:0] pixel_send;
    logic v_sync;
    logic h_sync;
    
    // //////////////////////////////////////
    // // for simulation purposes only!!!
    // logic [9:0]curr_x_pos_delayed;
    // logic [9:0]curr_y_pos_delayed;
    // ////////////////////////////////////
    
    
    gpu #(
        .ram_add_width (ram_add_width),
        .NR_OF_BLOBS   (NR_OF_BLOBS  )
    ) DUT
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
        // //////////////////////////////////////
        // // for simulation purposes only!!!
        // .curr_x_pos_delayed(curr_x_pos_delayed),
        // .curr_y_pos_delayed(curr_y_pos_delayed),
        // ////////////////////////////////////
        .pixel_send       (pixel_send   ),
        .v_sync           (v_sync       ),
        .h_sync           (h_sync       )
    );                                  
    
    parameter clk_period = 10;
    parameter clk_half_period = 5;
        
    always
        #clk_half_period clk = !clk;
    
    initial begin
        reset = 1;
        clk = 1;
        wr_req = 0;
        background = 12'hABC;
        
        sprite_enable[0] = 0;
        layer[0] = 3;
        x1_pos[0] <= 3;
        y1_pos[0] <= 5;
        x2_pos[0] <= 6;
        y2_pos[0] <= 7;
        ram_address[0] <= 50;

        sprite_enable[1] = 0;
        layer[1] = 2;
        x1_pos[1] <= 3;
        y1_pos[1] <= 5;
        x2_pos[1] <= 6;
        y2_pos[1] <= 7;
        ram_address[1] <= 1;

        sprite_enable[2] = 0;
        layer[2] = 1;
        x1_pos[2] <= 3;
        y1_pos[2] <= 5;
        x2_pos[2] <= 6;
        y2_pos[2] <= 7;
        ram_address[2] <= 100;

        sprite_enable[3] = 0;
        layer[3] = 0;
        x1_pos[3] <= 3;
        y1_pos[3] <= 5;
        x2_pos[3] <= 6;
        y2_pos[3] <= 7;
        ram_address[3] <= 150;
        
        #(5*clk_period);
        reset = 0;
        

        #(2*clk_period);
        sprite_enable[0] = 1;
        sprite_enable[1] = 0;
        sprite_enable[2] = 1;
        sprite_enable[3] = 1;
        #(2*2*2*10*2048*clk_period);
        // #(2*2*2*10*2048*clk_period);
        $stop;


    end


    
endmodule