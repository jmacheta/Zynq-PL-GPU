`timescale 1ns / 1ps
module delay
#(
    parameter delay_length = 10,
    parameter data_width = 12
)
(
    input  logic                  clk,
    input  wire [data_width-1:0]  data_in,
    output logic [data_width-1:0] data_out
);
    
    // shift register
    logic [data_width-1:0] srl_reg [delay_length-1:0];
    
    always @(posedge clk) begin
        int i;
        srl_reg[0] <= data_in;
        for (i=1; i<delay_length; i++)
            srl_reg[i] <= srl_reg[i-1];
    end
    
    assign data_out = srl_reg[delay_length-1];
    
endmodule