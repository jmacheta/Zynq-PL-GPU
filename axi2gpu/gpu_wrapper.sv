`timescale 1ns / 1ps                        
module gpu_wrapper                          
#(                                          
    parameter ram_add_width = 16,           
    parameter NR_OF_BLOBS = 32              
)                                           
(                                           
    input clk,  // system clock             
    input reset,                            

    // background color                     
    input wire [11:0] background,           

    // blobs settings:                      

    // BLOB0                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable0,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos0,                              
    input wire [9:0] x1_pos0,                              
    input wire [9:0] y2_pos0,                              
    input wire [9:0] x2_pos0,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address0,           
    input wire [1:0]  layer0,                              

    // BLOB1                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable1,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos1,                              
    input wire [9:0] x1_pos1,                              
    input wire [9:0] y2_pos1,                              
    input wire [9:0] x2_pos1,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address1,           
    input wire [1:0]  layer1,                              

    // BLOB2                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable2,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos2,                              
    input wire [9:0] x1_pos2,                              
    input wire [9:0] y2_pos2,                              
    input wire [9:0] x2_pos2,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address2,           
    input wire [1:0]  layer2,                              

    // BLOB3                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable3,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos3,                              
    input wire [9:0] x1_pos3,                              
    input wire [9:0] y2_pos3,                              
    input wire [9:0] x2_pos3,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address3,           
    input wire [1:0]  layer3,                              

    // BLOB4                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable4,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos4,                              
    input wire [9:0] x1_pos4,                              
    input wire [9:0] y2_pos4,                              
    input wire [9:0] x2_pos4,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address4,           
    input wire [1:0]  layer4,                              

    // BLOB5                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable5,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos5,                              
    input wire [9:0] x1_pos5,                              
    input wire [9:0] y2_pos5,                              
    input wire [9:0] x2_pos5,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address5,           
    input wire [1:0]  layer5,                              

    // BLOB6                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable6,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos6,                              
    input wire [9:0] x1_pos6,                              
    input wire [9:0] y2_pos6,                              
    input wire [9:0] x2_pos6,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address6,           
    input wire [1:0]  layer6,                              

    // BLOB7                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable7,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos7,                              
    input wire [9:0] x1_pos7,                              
    input wire [9:0] y2_pos7,                              
    input wire [9:0] x2_pos7,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address7,           
    input wire [1:0]  layer7,                              

    // BLOB8                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable8,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos8,                              
    input wire [9:0] x1_pos8,                              
    input wire [9:0] y2_pos8,                              
    input wire [9:0] x2_pos8,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address8,           
    input wire [1:0]  layer8,                              

    // BLOB9                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable9,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos9,                              
    input wire [9:0] x1_pos9,                              
    input wire [9:0] y2_pos9,                              
    input wire [9:0] x2_pos9,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address9,           
    input wire [1:0]  layer9,                              

    // BLOB10                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable10,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos10,                              
    input wire [9:0] x1_pos10,                              
    input wire [9:0] y2_pos10,                              
    input wire [9:0] x2_pos10,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address10,           
    input wire [1:0]  layer10,                              

    // BLOB11                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable11,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos11,                              
    input wire [9:0] x1_pos11,                              
    input wire [9:0] y2_pos11,                              
    input wire [9:0] x2_pos11,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address11,           
    input wire [1:0]  layer11,                              

    // BLOB12                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable12,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos12,                              
    input wire [9:0] x1_pos12,                              
    input wire [9:0] y2_pos12,                              
    input wire [9:0] x2_pos12,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address12,           
    input wire [1:0]  layer12,                              

    // BLOB13                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable13,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos13,                              
    input wire [9:0] x1_pos13,                              
    input wire [9:0] y2_pos13,                              
    input wire [9:0] x2_pos13,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address13,           
    input wire [1:0]  layer13,                              

    // BLOB14                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable14,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos14,                              
    input wire [9:0] x1_pos14,                              
    input wire [9:0] y2_pos14,                              
    input wire [9:0] x2_pos14,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address14,           
    input wire [1:0]  layer14,                              

    // BLOB15                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable15,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos15,                              
    input wire [9:0] x1_pos15,                              
    input wire [9:0] y2_pos15,                              
    input wire [9:0] x2_pos15,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address15,           
    input wire [1:0]  layer15,                              

    // BLOB16                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable16,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos16,                              
    input wire [9:0] x1_pos16,                              
    input wire [9:0] y2_pos16,                              
    input wire [9:0] x2_pos16,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address16,           
    input wire [1:0]  layer16,                              

    // BLOB17                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable17,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos17,                              
    input wire [9:0] x1_pos17,                              
    input wire [9:0] y2_pos17,                              
    input wire [9:0] x2_pos17,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address17,           
    input wire [1:0]  layer17,                              

    // BLOB18                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable18,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos18,                              
    input wire [9:0] x1_pos18,                              
    input wire [9:0] y2_pos18,                              
    input wire [9:0] x2_pos18,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address18,           
    input wire [1:0]  layer18,                              

    // BLOB19                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable19,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos19,                              
    input wire [9:0] x1_pos19,                              
    input wire [9:0] y2_pos19,                              
    input wire [9:0] x2_pos19,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address19,           
    input wire [1:0]  layer19,                              

    // BLOB20                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable20,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos20,                              
    input wire [9:0] x1_pos20,                              
    input wire [9:0] y2_pos20,                              
    input wire [9:0] x2_pos20,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address20,           
    input wire [1:0]  layer20,                              

    // BLOB21                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable21,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos21,                              
    input wire [9:0] x1_pos21,                              
    input wire [9:0] y2_pos21,                              
    input wire [9:0] x2_pos21,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address21,           
    input wire [1:0]  layer21,                              

    // BLOB22                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable22,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos22,                              
    input wire [9:0] x1_pos22,                              
    input wire [9:0] y2_pos22,                              
    input wire [9:0] x2_pos22,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address22,           
    input wire [1:0]  layer22,                              

    // BLOB23                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable23,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos23,                              
    input wire [9:0] x1_pos23,                              
    input wire [9:0] y2_pos23,                              
    input wire [9:0] x2_pos23,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address23,           
    input wire [1:0]  layer23,                              

    // BLOB24                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable24,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos24,                              
    input wire [9:0] x1_pos24,                              
    input wire [9:0] y2_pos24,                              
    input wire [9:0] x2_pos24,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address24,           
    input wire [1:0]  layer24,                              

    // BLOB25                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable25,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos25,                              
    input wire [9:0] x1_pos25,                              
    input wire [9:0] y2_pos25,                              
    input wire [9:0] x2_pos25,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address25,           
    input wire [1:0]  layer25,                              

    // BLOB26                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable26,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos26,                              
    input wire [9:0] x1_pos26,                              
    input wire [9:0] y2_pos26,                              
    input wire [9:0] x2_pos26,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address26,           
    input wire [1:0]  layer26,                              

    // BLOB27                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable27,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos27,                              
    input wire [9:0] x1_pos27,                              
    input wire [9:0] y2_pos27,                              
    input wire [9:0] x2_pos27,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address27,           
    input wire [1:0]  layer27,                              

    // BLOB28                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable28,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos28,                              
    input wire [9:0] x1_pos28,                              
    input wire [9:0] y2_pos28,                              
    input wire [9:0] x2_pos28,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address28,           
    input wire [1:0]  layer28,                              

    // BLOB29                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable29,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos29,                              
    input wire [9:0] x1_pos29,                              
    input wire [9:0] y2_pos29,                              
    input wire [9:0] x2_pos29,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address29,           
    input wire [1:0]  layer29,                              

    // BLOB30                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable30,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos30,                              
    input wire [9:0] x1_pos30,                              
    input wire [9:0] y2_pos30,                              
    input wire [9:0] x2_pos30,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address30,           
    input wire [1:0]  layer30,                              

    // BLOB31                                               
    // enable sprite  (show it on screen)                   
    input wire sprite_enable31,                             
    // position on the screen (y - vertical, x - horizontal)
    input wire [9:0] y1_pos31,                              
    input wire [9:0] x1_pos31,                              
    input wire [9:0] y2_pos31,                              
    input wire [9:0] x2_pos31,                              
    // start address in RAM, TBD MSBs are nr of BRAM        
    input wire [ram_add_width-1:0] ram_address31,           
    input wire [1:0]  layer31,                              

    // BRAM write ports                                     
    input wire [ram_add_width-1:0]  wr_add,                 
    input wire [11:0] wr_data,                              
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

    // BLOB0                                   
    assign  sprite_enable[0] = sprite_enable0;
    assign         y1_pos[0] =        y1_pos0;
    assign         x1_pos[0] =        x1_pos0;
    assign         y2_pos[0] =        y2_pos0;
    assign         x2_pos[0] =        x2_pos0;
    assign    ram_address[0] =   ram_address0;
    assign          layer[0] =         layer0;

    // BLOB1                                   
    assign  sprite_enable[1] = sprite_enable1;
    assign         y1_pos[1] =        y1_pos1;
    assign         x1_pos[1] =        x1_pos1;
    assign         y2_pos[1] =        y2_pos1;
    assign         x2_pos[1] =        x2_pos1;
    assign    ram_address[1] =   ram_address1;
    assign          layer[1] =         layer1;

    // BLOB2                                   
    assign  sprite_enable[2] = sprite_enable2;
    assign         y1_pos[2] =        y1_pos2;
    assign         x1_pos[2] =        x1_pos2;
    assign         y2_pos[2] =        y2_pos2;
    assign         x2_pos[2] =        x2_pos2;
    assign    ram_address[2] =   ram_address2;
    assign          layer[2] =         layer2;

    // BLOB3                                   
    assign  sprite_enable[3] = sprite_enable3;
    assign         y1_pos[3] =        y1_pos3;
    assign         x1_pos[3] =        x1_pos3;
    assign         y2_pos[3] =        y2_pos3;
    assign         x2_pos[3] =        x2_pos3;
    assign    ram_address[3] =   ram_address3;
    assign          layer[3] =         layer3;

    // BLOB4                                   
    assign  sprite_enable[4] = sprite_enable4;
    assign         y1_pos[4] =        y1_pos4;
    assign         x1_pos[4] =        x1_pos4;
    assign         y2_pos[4] =        y2_pos4;
    assign         x2_pos[4] =        x2_pos4;
    assign    ram_address[4] =   ram_address4;
    assign          layer[4] =         layer4;

    // BLOB5                                   
    assign  sprite_enable[5] = sprite_enable5;
    assign         y1_pos[5] =        y1_pos5;
    assign         x1_pos[5] =        x1_pos5;
    assign         y2_pos[5] =        y2_pos5;
    assign         x2_pos[5] =        x2_pos5;
    assign    ram_address[5] =   ram_address5;
    assign          layer[5] =         layer5;

    // BLOB6                                   
    assign  sprite_enable[6] = sprite_enable6;
    assign         y1_pos[6] =        y1_pos6;
    assign         x1_pos[6] =        x1_pos6;
    assign         y2_pos[6] =        y2_pos6;
    assign         x2_pos[6] =        x2_pos6;
    assign    ram_address[6] =   ram_address6;
    assign          layer[6] =         layer6;

    // BLOB7                                   
    assign  sprite_enable[7] = sprite_enable7;
    assign         y1_pos[7] =        y1_pos7;
    assign         x1_pos[7] =        x1_pos7;
    assign         y2_pos[7] =        y2_pos7;
    assign         x2_pos[7] =        x2_pos7;
    assign    ram_address[7] =   ram_address7;
    assign          layer[7] =         layer7;

    // BLOB8                                   
    assign  sprite_enable[8] = sprite_enable8;
    assign         y1_pos[8] =        y1_pos8;
    assign         x1_pos[8] =        x1_pos8;
    assign         y2_pos[8] =        y2_pos8;
    assign         x2_pos[8] =        x2_pos8;
    assign    ram_address[8] =   ram_address8;
    assign          layer[8] =         layer8;

    // BLOB9                                   
    assign  sprite_enable[9] = sprite_enable9;
    assign         y1_pos[9] =        y1_pos9;
    assign         x1_pos[9] =        x1_pos9;
    assign         y2_pos[9] =        y2_pos9;
    assign         x2_pos[9] =        x2_pos9;
    assign    ram_address[9] =   ram_address9;
    assign          layer[9] =         layer9;

    // BLOB10                                   
    assign  sprite_enable[10] = sprite_enable10;
    assign         y1_pos[10] =        y1_pos10;
    assign         x1_pos[10] =        x1_pos10;
    assign         y2_pos[10] =        y2_pos10;
    assign         x2_pos[10] =        x2_pos10;
    assign    ram_address[10] =   ram_address10;
    assign          layer[10] =         layer10;

    // BLOB11                                   
    assign  sprite_enable[11] = sprite_enable11;
    assign         y1_pos[11] =        y1_pos11;
    assign         x1_pos[11] =        x1_pos11;
    assign         y2_pos[11] =        y2_pos11;
    assign         x2_pos[11] =        x2_pos11;
    assign    ram_address[11] =   ram_address11;
    assign          layer[11] =         layer11;

    // BLOB12                                   
    assign  sprite_enable[12] = sprite_enable12;
    assign         y1_pos[12] =        y1_pos12;
    assign         x1_pos[12] =        x1_pos12;
    assign         y2_pos[12] =        y2_pos12;
    assign         x2_pos[12] =        x2_pos12;
    assign    ram_address[12] =   ram_address12;
    assign          layer[12] =         layer12;

    // BLOB13                                   
    assign  sprite_enable[13] = sprite_enable13;
    assign         y1_pos[13] =        y1_pos13;
    assign         x1_pos[13] =        x1_pos13;
    assign         y2_pos[13] =        y2_pos13;
    assign         x2_pos[13] =        x2_pos13;
    assign    ram_address[13] =   ram_address13;
    assign          layer[13] =         layer13;

    // BLOB14                                   
    assign  sprite_enable[14] = sprite_enable14;
    assign         y1_pos[14] =        y1_pos14;
    assign         x1_pos[14] =        x1_pos14;
    assign         y2_pos[14] =        y2_pos14;
    assign         x2_pos[14] =        x2_pos14;
    assign    ram_address[14] =   ram_address14;
    assign          layer[14] =         layer14;

    // BLOB15                                   
    assign  sprite_enable[15] = sprite_enable15;
    assign         y1_pos[15] =        y1_pos15;
    assign         x1_pos[15] =        x1_pos15;
    assign         y2_pos[15] =        y2_pos15;
    assign         x2_pos[15] =        x2_pos15;
    assign    ram_address[15] =   ram_address15;
    assign          layer[15] =         layer15;

    // BLOB16                                   
    assign  sprite_enable[16] = sprite_enable16;
    assign         y1_pos[16] =        y1_pos16;
    assign         x1_pos[16] =        x1_pos16;
    assign         y2_pos[16] =        y2_pos16;
    assign         x2_pos[16] =        x2_pos16;
    assign    ram_address[16] =   ram_address16;
    assign          layer[16] =         layer16;

    // BLOB17                                   
    assign  sprite_enable[17] = sprite_enable17;
    assign         y1_pos[17] =        y1_pos17;
    assign         x1_pos[17] =        x1_pos17;
    assign         y2_pos[17] =        y2_pos17;
    assign         x2_pos[17] =        x2_pos17;
    assign    ram_address[17] =   ram_address17;
    assign          layer[17] =         layer17;

    // BLOB18                                   
    assign  sprite_enable[18] = sprite_enable18;
    assign         y1_pos[18] =        y1_pos18;
    assign         x1_pos[18] =        x1_pos18;
    assign         y2_pos[18] =        y2_pos18;
    assign         x2_pos[18] =        x2_pos18;
    assign    ram_address[18] =   ram_address18;
    assign          layer[18] =         layer18;

    // BLOB19                                   
    assign  sprite_enable[19] = sprite_enable19;
    assign         y1_pos[19] =        y1_pos19;
    assign         x1_pos[19] =        x1_pos19;
    assign         y2_pos[19] =        y2_pos19;
    assign         x2_pos[19] =        x2_pos19;
    assign    ram_address[19] =   ram_address19;
    assign          layer[19] =         layer19;

    // BLOB20                                   
    assign  sprite_enable[20] = sprite_enable20;
    assign         y1_pos[20] =        y1_pos20;
    assign         x1_pos[20] =        x1_pos20;
    assign         y2_pos[20] =        y2_pos20;
    assign         x2_pos[20] =        x2_pos20;
    assign    ram_address[20] =   ram_address20;
    assign          layer[20] =         layer20;

    // BLOB21                                   
    assign  sprite_enable[21] = sprite_enable21;
    assign         y1_pos[21] =        y1_pos21;
    assign         x1_pos[21] =        x1_pos21;
    assign         y2_pos[21] =        y2_pos21;
    assign         x2_pos[21] =        x2_pos21;
    assign    ram_address[21] =   ram_address21;
    assign          layer[21] =         layer21;

    // BLOB22                                   
    assign  sprite_enable[22] = sprite_enable22;
    assign         y1_pos[22] =        y1_pos22;
    assign         x1_pos[22] =        x1_pos22;
    assign         y2_pos[22] =        y2_pos22;
    assign         x2_pos[22] =        x2_pos22;
    assign    ram_address[22] =   ram_address22;
    assign          layer[22] =         layer22;

    // BLOB23                                   
    assign  sprite_enable[23] = sprite_enable23;
    assign         y1_pos[23] =        y1_pos23;
    assign         x1_pos[23] =        x1_pos23;
    assign         y2_pos[23] =        y2_pos23;
    assign         x2_pos[23] =        x2_pos23;
    assign    ram_address[23] =   ram_address23;
    assign          layer[23] =         layer23;

    // BLOB24                                   
    assign  sprite_enable[24] = sprite_enable24;
    assign         y1_pos[24] =        y1_pos24;
    assign         x1_pos[24] =        x1_pos24;
    assign         y2_pos[24] =        y2_pos24;
    assign         x2_pos[24] =        x2_pos24;
    assign    ram_address[24] =   ram_address24;
    assign          layer[24] =         layer24;

    // BLOB25                                   
    assign  sprite_enable[25] = sprite_enable25;
    assign         y1_pos[25] =        y1_pos25;
    assign         x1_pos[25] =        x1_pos25;
    assign         y2_pos[25] =        y2_pos25;
    assign         x2_pos[25] =        x2_pos25;
    assign    ram_address[25] =   ram_address25;
    assign          layer[25] =         layer25;

    // BLOB26                                   
    assign  sprite_enable[26] = sprite_enable26;
    assign         y1_pos[26] =        y1_pos26;
    assign         x1_pos[26] =        x1_pos26;
    assign         y2_pos[26] =        y2_pos26;
    assign         x2_pos[26] =        x2_pos26;
    assign    ram_address[26] =   ram_address26;
    assign          layer[26] =         layer26;

    // BLOB27                                   
    assign  sprite_enable[27] = sprite_enable27;
    assign         y1_pos[27] =        y1_pos27;
    assign         x1_pos[27] =        x1_pos27;
    assign         y2_pos[27] =        y2_pos27;
    assign         x2_pos[27] =        x2_pos27;
    assign    ram_address[27] =   ram_address27;
    assign          layer[27] =         layer27;

    // BLOB28                                   
    assign  sprite_enable[28] = sprite_enable28;
    assign         y1_pos[28] =        y1_pos28;
    assign         x1_pos[28] =        x1_pos28;
    assign         y2_pos[28] =        y2_pos28;
    assign         x2_pos[28] =        x2_pos28;
    assign    ram_address[28] =   ram_address28;
    assign          layer[28] =         layer28;

    // BLOB29                                   
    assign  sprite_enable[29] = sprite_enable29;
    assign         y1_pos[29] =        y1_pos29;
    assign         x1_pos[29] =        x1_pos29;
    assign         y2_pos[29] =        y2_pos29;
    assign         x2_pos[29] =        x2_pos29;
    assign    ram_address[29] =   ram_address29;
    assign          layer[29] =         layer29;

    // BLOB30                                   
    assign  sprite_enable[30] = sprite_enable30;
    assign         y1_pos[30] =        y1_pos30;
    assign         x1_pos[30] =        x1_pos30;
    assign         y2_pos[30] =        y2_pos30;
    assign         x2_pos[30] =        x2_pos30;
    assign    ram_address[30] =   ram_address30;
    assign          layer[30] =         layer30;

    // BLOB31                                   
    assign  sprite_enable[31] = sprite_enable31;
    assign         y1_pos[31] =        y1_pos31;
    assign         x1_pos[31] =        x1_pos31;
    assign         y2_pos[31] =        y2_pos31;
    assign         x2_pos[31] =        x2_pos31;
    assign    ram_address[31] =   ram_address31;
    assign          layer[31] =         layer31;

endmodule
