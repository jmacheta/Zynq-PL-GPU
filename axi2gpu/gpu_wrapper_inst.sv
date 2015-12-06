    localparam ram_add_width = 16;
    wire wr_req =  (slv_reg_wren) & (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]== 5'h2);
    
    gpu_wrapper #(                                             
            .ram_add_width (ram_add_width),                    
            .NR_OF_BLOBS   (4)                                
        ) gpu_wrapper_i                                        
        (                                                      
            .clk              (S_AXI_ACLK    ), 
            .reset            (!S_AXI_ARESETN), 
            .slv_reg0        (slv_reg0     ), 
            .slv_reg1        (slv_reg1     ), 
            .slv_reg2        (slv_reg2     ), 
            .slv_reg3        (slv_reg3     ), 
            .slv_reg4        (slv_reg4     ), 
            .slv_reg5        (slv_reg5     ), 
            .slv_reg6        (slv_reg6     ), 
            .slv_reg7        (slv_reg7     ), 
            .slv_reg8        (slv_reg8     ), 
            .slv_reg9        (slv_reg9     ), 
            .slv_reg10        (slv_reg10     ), 
            .slv_reg11        (slv_reg11     ), 
            .slv_reg12        (slv_reg12     ), 
            .slv_reg13        (slv_reg13     ), 
            .slv_reg14        (slv_reg14     ), 
            .slv_reg15        (slv_reg15     ), 
            .wr_req           (wr_req        ),
            .pixel_send       (pixel_send    ),
            .v_sync           (v_sync        ),
            .h_sync           (h_sync        ) 
        );
