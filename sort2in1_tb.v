/* -------------
Project: Sort all data with heap method
always keep max 16 values
Author: liqh
Date: 2021-10-29

--------------*/

`define dump_top  sort2in1_tb                
`define TB_TOP    sort2in1_tb
`define DISPLAY_OK 1
                
`define dump_level 10
`define DATA_WIDTH 12

`define DATA_FILE "./sort.dat"
        
`include "system_init.v"                           
//`include "read_enable_signal.v"                    
`include "read_signal.v"                    
`include "tb_clock_div.v"		                      
                                                     
module sort2in1_tb 
#(parameter W =`DATA_WIDTH ) 
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
	tb_clock_div #( 2) U_clkDiv160  ( .clk_in(clk),.rst(synrst), .clk_out(clkDiv160) );  //  clkDiv160 should be used in read_enable_signal
	//read_enable_signal #(`DATA_WIDTH,`DATA_FILE,`DISPLAY_OK) U_data_in(.clk(clk),.enable(rst_x),.signal_out(Data_in)); 
  read_signal #(`DATA_WIDTH,`DATA_FILE,`DISPLAY_OK) U_data_in(.clk(clk),.signal_out(Data_in)); 

wire DataEn;
wire [W-1:0] DataIn;
wire [W-1:0] DataMax;    
wire [W+3:0] DataSumOut;
                                                 
assign DataEn=1;
assign DataIn=Data_in;
 
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
