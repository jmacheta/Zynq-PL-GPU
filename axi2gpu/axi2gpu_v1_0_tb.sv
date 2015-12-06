module gpu_tb();
    localparam integer C_S00_AXI_DATA_WIDTH	= 32;
	localparam integer C_S00_AXI_ADDR_WIDTH	= 7;
    wire [11:0] pixel_send;
    wire v_sync;
    wire h_sync;
    // Ports of Axi Slave Bus Interface S00_AXI
    logic  s00_axi_aclk = 0;                                   // input 
    logic  s00_axi_aresetn;                                    // input 
    logic [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr;         // input 
    logic [2 : 0] s00_axi_awprot = 0;                          // input 
    logic  s00_axi_awvalid;                                    // input 
    logic  s00_axi_awready;                                    // output
    logic [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata;          // input 
    logic [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb;      // input 
    logic  s00_axi_wvalid;                                     // input 
    logic  s00_axi_wready;                                     // output
    logic [1 : 0] s00_axi_bresp;                               // output
    logic  s00_axi_bvalid;                                     // output
    logic  s00_axi_bready;                                     // input 
    logic [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr;         // input 
    logic [2 : 0] s00_axi_arprot;                              // input 
    logic  s00_axi_arvalid;                                    // input 
    logic  s00_axi_arready;                                    // output
    logic [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata;          // output
    logic [1 : 0] s00_axi_rresp;                               // output
    logic  s00_axi_rvalid;                                     // output
    logic  s00_axi_rready;                                     // input 
    
    // DUT
    axi2gpu_v1_0 DUT (
        .pixel_send          (pixel_send     ),
        .v_sync              (v_sync         ),
        .h_sync              (h_sync         ),
        .s00_axi_aclk        (s00_axi_aclk   ),
        .s00_axi_aresetn     (s00_axi_aresetn),
        .s00_axi_awaddr      (s00_axi_awaddr ),
        .s00_axi_awprot      (s00_axi_awprot ),
        .s00_axi_awvalid     (s00_axi_awvalid),
        .s00_axi_awready     (s00_axi_awready),
        .s00_axi_wdata       (s00_axi_wdata  ),
        .s00_axi_wstrb       (s00_axi_wstrb  ),
        .s00_axi_wvalid      (s00_axi_wvalid ),
        .s00_axi_wready      (s00_axi_wready ),
        .s00_axi_bresp       (s00_axi_bresp  ),
        .s00_axi_bvalid      (s00_axi_bvalid ),
        .s00_axi_bready      (s00_axi_bready ),
        .s00_axi_araddr      (s00_axi_araddr ),
        .s00_axi_arprot      (s00_axi_arprot ),
        .s00_axi_arvalid     (s00_axi_arvalid),
        .s00_axi_arready     (s00_axi_arready),
        .s00_axi_rdata       (s00_axi_rdata  ),
        .s00_axi_rresp       (s00_axi_rresp  ),
        .s00_axi_rvalid      (s00_axi_rvalid ),
        .s00_axi_rready      (s00_axi_rready )
    );
    
    task axi_write(
        logic [4:0] register_nr,
        logic [C_S00_AXI_DATA_WIDTH-1 : 0] data
        );
        @(posedge s00_axi_aclk);
        s00_axi_wvalid = '1;
        s00_axi_awaddr = {register_nr,2'b0};
        s00_axi_awvalid = '1;
        s00_axi_wstrb = '1;
        s00_axi_wdata = data;
        @(posedge s00_axi_aclk);
        @(posedge s00_axi_aclk);
        @(posedge s00_axi_aclk);
        s00_axi_wstrb = '0;
        @(posedge s00_axi_aclk);
        @(posedge s00_axi_aclk);
    endtask
    
    parameter clk_period = 10;
    parameter clk_half_period = 5;
        
    always
        #clk_half_period s00_axi_aclk = !s00_axi_aclk;
    
    initial begin
        s00_axi_aresetn = 0;
        # (200 * clk_period);
        s00_axi_aresetn = 1;
        # (20 * clk_period);
        
        axi_write(0,32'h00000ABC);
        
        axi_write(4,{2'd0,10'd52,10'd40,10'd50});
        axi_write(5,{22'd3,10'd45});
        axi_write(6,0);
        
        // register1
        //      3:0 - enable sprite (all sprites in one register)
        axi_write(3,1);
        
        // # (5000*1000 * clk_period);
        // $stop;
    end
    
endmodule