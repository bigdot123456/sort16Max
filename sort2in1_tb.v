/* -------------
Project: Sort all data with heap method
always keep max 16 values
Author: liqh
Date: 2021-10-29

--------------*/

`define dump_top  sort2in1_tb                
`define TB_TOP    sort2in1_tb
                
`define dump_level 10
`define DATA_WIDTH 8

`define DATA_FILE "./sort_tb.dat"
        
`include "system_init.v"                           
`include "read_enable_signal.v"                    
`include "tb_clock_div.v"		                      
                                                     
module sort2in1_tb 
#(parameter W =12 ) 
(
);    
                       
  reg  clk;                                          
  reg  rst_x;                                        
  wire synrst;                                      
                                                     
 `include "init_dump.v"
  system_init  system_init();                        

                                                     
  initial                                            
  begin                                              
    force clk       = system_init.masterclock;       
    force rst_x     = system_init.rst_all    ;       
  end                                                
  assign synrst = system_init.syn_rst;              
                                                     
                                                     
 wire [`DATA_WIDTH-1:0]  Data_in;                   
                                                     
	wire clkDiv160;                                     
	tb_clock_div #( 160) U_clkDiv160  ( .clk_in(clk),.rst(synrst), .clk_out(clkDiv160) ); 
	read_enable_signal #(`DATA_WIDTH,`DATA_FILE) U_data_in(.clk(clkDiv160),.enable(rst_x),.signal_out(Data_in)); 

wire DataEn;
wire [W-1:0] DataIn;
wire [W-1:0] DataMax;    
wire [W+3:0] DataSumOut;
                                                 
assign DataEn=1;
assign DataIn=0;
 
sort2in1 #(.W(12))U_sort2in1
(
    .clk               (clk          ), 
    .synrst            (synrst       ), 
    .DataEn            (DataEn       ), 
    .DataIn            (DataIn       ), 
    .DataMax           (DataMax      ), 
    .DataSumOut        (DataSumOut   ) 
    );
       
       
endmodule
