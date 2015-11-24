`timescale 1ns / 1ps                        
module ram                                  
#(                                          
    parameter ram_width = 8,                
    parameter data_width = 12                 
)                                           
(       
    input rd_clk,
    input wr_clk,
    input [ram_width-1:0] wr_add,                                     
    input [data_width-1:0] wr_data,                                     
    input wr_req,                                     
    input [ram_width-1:0] rd_add,                 
    //input rd_req,
    output [data_width-1:0] rd_data                 
    );                                      
                                            
    localparam lut_depth = 1 << ram_width;    
    logic [data_width-1:0] mem [lut_depth-1:0];
    reg   [data_width-1:0] out_data_reg;
                                            
    always @(posedge wr_clk)                   
        if (wr_req)                         
            mem[wr_add] <= wr_data;         
                                            
    always @(posedge rd_clk)                   
        //if (rd_req)                       
        out_data_reg <= mem[rd_add];         
                                            
    assign rd_data = out_data_reg;                

    initial begin                

        mem[0] = 12'h00A;// valid pixel
        mem[1] = 12'h001;
        mem[2] = 12'h002;
        mem[3] = 12'h003;
        mem[4] = 12'h000;//not-valid pixel
        mem[5] = 12'h005;
        mem[6] = 12'h006;
        mem[7] = 12'h007;
        mem[8] = 12'h008;
        mem[9] = 12'h009;
        mem[10] = 12'h00A;
        mem[11] = 12'h00B;
        mem[12] = 12'h00C;
        mem[13] = 12'h00D;
        mem[14] = 12'h00E;
        mem[15] = 12'h00F;
        mem[16] = 12'h010;
        mem[17] = 12'h011;
        mem[18] = 12'h012;
        mem[19] = 12'h013;
        mem[20] = 12'h014;
        mem[21] = 12'h015;
        mem[22] = 12'h016;
        mem[23] = 12'h017;
        mem[24] = 12'h018;
        mem[25] = 12'h019;
        mem[26] = 12'h01A;
        mem[27] = 12'h01B;
        mem[28] = 12'h01C;
        mem[29] = 12'h01D;
        mem[30] = 12'h01E;
        mem[31] = 12'h01F;
        mem[32] = 12'h020;
        mem[33] = 12'h021;
        mem[34] = 12'h022;
        mem[35] = 12'h023;
        mem[36] = 12'h024;
        mem[37] = 12'h025;
        mem[38] = 12'h026;
        mem[39] = 12'h027;
        mem[40] = 12'h028;
        mem[41] = 12'h029;
        mem[42] = 12'h02A;
        mem[43] = 12'h02B;
        mem[44] = 12'h02C;
        mem[45] = 12'h02D;
        mem[46] = 12'h02E;
        mem[47] = 12'h02F;
        mem[48] = 12'h030;
        mem[49] = 12'h031;
        mem[50] = 12'h032;
        mem[51] = 12'h000;//not-valid pixel
        mem[52] = 12'h034;
        mem[53] = 12'h000;//not-valid pixel
        mem[54] = 12'h036;
        mem[55] = 12'h037;
        mem[56] = 12'h038;
        mem[57] = 12'h039;
        mem[58] = 12'h03A;
        mem[59] = 12'h03B;
        mem[60] = 12'h03C;
        mem[61] = 12'h03D;
        mem[62] = 12'h03E;
        mem[63] = 12'h03F;
        mem[64] = 12'h040;
        mem[65] = 12'h041;
        mem[66] = 12'h042;
        mem[67] = 12'h043;
        mem[68] = 12'h044;
        mem[69] = 12'h045;
        mem[70] = 12'h046;
        mem[71] = 12'h047;
        mem[72] = 12'h048;
        mem[73] = 12'h049;
        mem[74] = 12'h04A;
        mem[75] = 12'h04B;
        mem[76] = 12'h04C;
        mem[77] = 12'h04D;
        mem[78] = 12'h04E;
        mem[79] = 12'h04F;
        mem[80] = 12'h050;
        mem[81] = 12'h051;
        mem[82] = 12'h052;
        mem[83] = 12'h053;
        mem[84] = 12'h054;
        mem[85] = 12'h055;
        mem[86] = 12'h056;
        mem[87] = 12'h057;
        mem[88] = 12'h058;
        mem[89] = 12'h059;
        mem[90] = 12'h05A;
        mem[91] = 12'h05B;
        mem[92] = 12'h05C;
        mem[93] = 12'h05D;
        mem[94] = 12'h05E;
        mem[95] = 12'h05F;
        mem[96] = 12'h060;
        mem[97] = 12'h061;
        mem[98] = 12'h062;
        mem[99] = 12'h063;
        mem[100] = 12'h064;
        mem[101] = 12'h065;
        mem[102] = 12'h066;
        mem[103] = 12'h000;//not-valid pixel
        mem[104] = 12'h068;
        mem[105] = 12'h069;
        mem[106] = 12'h06A;
        mem[107] = 12'h06B;
        mem[108] = 12'h06C;
        mem[109] = 12'h06D;
        mem[110] = 12'h06E;
        mem[111] = 12'h06F;
        mem[112] = 12'h070;
        mem[113] = 12'h071;
        mem[114] = 12'h072;
        mem[115] = 12'h073;
        mem[116] = 12'h074;
        mem[117] = 12'h075;
        mem[118] = 12'h076;
        mem[119] = 12'h077;
        mem[120] = 12'h078;
        mem[121] = 12'h079;
        mem[122] = 12'h07A;
        mem[123] = 12'h07B;
        mem[124] = 12'h07C;
        mem[125] = 12'h07D;
        mem[126] = 12'h07E;
        mem[127] = 12'h07F;
        mem[128] = 12'h080;
        mem[129] = 12'h081;
        mem[130] = 12'h082;
        mem[131] = 12'h083;
        mem[132] = 12'h084;
        mem[133] = 12'h085;
        mem[134] = 12'h086;
        mem[135] = 12'h087;
        mem[136] = 12'h088;
        mem[137] = 12'h089;
        mem[138] = 12'h08A;
        mem[139] = 12'h08B;
        mem[140] = 12'h08C;
        mem[141] = 12'h08D;
        mem[142] = 12'h08E;
        mem[143] = 12'h08F;
        mem[144] = 12'h090;
        mem[145] = 12'h091;
        mem[146] = 12'h092;
        mem[147] = 12'h093;
        mem[148] = 12'h094;
        mem[149] = 12'h095;
        mem[150] = 12'h096;
        mem[151] = 12'h097;
        mem[152] = 12'h098;
        mem[153] = 12'h099;
        mem[154] = 12'h09A;
        mem[155] = 12'h09B;
        mem[156] = 12'h09C;
        mem[157] = 12'h09D;
        mem[158] = 12'h09E;
        mem[159] = 12'h09F;
        mem[160] = 12'h0A0;
        mem[161] = 12'h0A1;
        mem[162] = 12'h0A2;
        mem[163] = 12'h0A3;
        mem[164] = 12'h0A4;
        mem[165] = 12'h0A5;
        mem[166] = 12'h0A6;
        mem[167] = 12'h0A7;
        mem[168] = 12'h0A8;
        mem[169] = 12'h0A9;
        mem[170] = 12'h0AA;
        mem[171] = 12'h0AB;
        mem[172] = 12'h0AC;
        mem[173] = 12'h0AD;
        mem[174] = 12'h0AE;
        mem[175] = 12'h0AF;
        mem[176] = 12'h0B0;
        mem[177] = 12'h0B1;
        mem[178] = 12'h0B2;
        mem[179] = 12'h0B3;
        mem[180] = 12'h0B4;
        mem[181] = 12'h0B5;
        mem[182] = 12'h0B6;
        mem[183] = 12'h0B7;
        mem[184] = 12'h0B8;
        mem[185] = 12'h0B9;
        mem[186] = 12'h0BA;
        mem[187] = 12'h0BB;
        mem[188] = 12'h0BC;
        mem[189] = 12'h0BD;
        mem[190] = 12'h0BE;
        mem[191] = 12'h0BF;
        mem[192] = 12'h0C0;
        mem[193] = 12'h0C1;
        mem[194] = 12'h0C2;
        mem[195] = 12'h0C3;
        mem[196] = 12'h0C4;
        mem[197] = 12'h0C5;
        mem[198] = 12'h0C6;
        mem[199] = 12'h0C7;
        mem[200] = 12'h0C8;
        mem[201] = 12'h0C9;
        mem[202] = 12'h0CA;
        mem[203] = 12'h0CB;
        mem[204] = 12'h0CC;
        mem[205] = 12'h0CD;
        mem[206] = 12'h0CE;
        mem[207] = 12'h0CF;
        mem[208] = 12'h0D0;
        mem[209] = 12'h0D1;
        mem[210] = 12'h0D2;
        mem[211] = 12'h0D3;
        mem[212] = 12'h0D4;
        mem[213] = 12'h0D5;
        mem[214] = 12'h0D6;
        mem[215] = 12'h0D7;
        mem[216] = 12'h0D8;
        mem[217] = 12'h0D9;
        mem[218] = 12'h0DA;
        mem[219] = 12'h0DB;
        mem[220] = 12'h0DC;
        mem[221] = 12'h0DD;
        mem[222] = 12'h0DE;
        mem[223] = 12'h0DF;
        mem[224] = 12'h0E0;
        mem[225] = 12'h0E1;
        mem[226] = 12'h0E2;
        mem[227] = 12'h0E3;
        mem[228] = 12'h0E4;
        mem[229] = 12'h0E5;
        mem[230] = 12'h0E6;
        mem[231] = 12'h0E7;
        mem[232] = 12'h0E8;
        mem[233] = 12'h0E9;
        mem[234] = 12'h0EA;
        mem[235] = 12'h0EB;
        mem[236] = 12'h0EC;
        mem[237] = 12'h0ED;
        mem[238] = 12'h0EE;
        mem[239] = 12'h0EF;
        mem[240] = 12'h0F0;
        mem[241] = 12'h0F1;
        mem[242] = 12'h0F2;
        mem[243] = 12'h0F3;
        mem[244] = 12'h0F4;
        mem[245] = 12'h0F5;
        mem[246] = 12'h0F6;
        mem[247] = 12'h0F7;
        mem[248] = 12'h0F8;
        mem[249] = 12'h0F9;
        mem[250] = 12'h0FA;
        mem[251] = 12'h0FB;
        mem[252] = 12'h0FC;
        mem[253] = 12'h0FD;
        mem[254] = 12'h0FE;
        mem[255] = 12'h0FF;
    end

endmodule
