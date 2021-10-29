/* *****************************************    read data module ******************* */
/* **********        1) Main clock and test clock set to 50MHz                    ** */
/* **********        2) Auto stop time is 10Us                                    ** */
/* **********                                                                     ** */
/* **********                                                                     ** */
/* **********                                                                     ** */
/* ***************************************** GS Core ******************************* */

// Create by Mr. Liqinghua
// rev.0.1 2006.07.17
// rev.0.2 2006.07.24

`timescale 1ns/1ps 

`define LAST_TIME 3_000_000
//write_enable_signal #(8,"agc_I.dat","agc_I",1,1)U_DATA_I(.clk(clk_36M ),.enable (`DSSS_rx_core.resample_valid),.signal_out (`DSSS_rx_core.resample_I));

`define DLY_1 1
module write_enable_signal
#(
parameter signal_WIDTH=10,
parameter FILENAME="./pat/dfai.dat",
parameter signal_NAME="DATA",
parameter repeat_time=1,
parameter delay=2,
parameter display_OK=0
)
(
input clk,
input enable,
input signed [signal_WIDTH-1:0] signal_out
);

integer signal_FILE,signal_FILE1; 
integer index=0;
reg signal_isNotFirstRise = 0;
reg signal_isSimulationEnd= 0;
reg signed [signal_WIDTH-1:0] tmp_sig_I;
	
	initial
	begin
  $display("writing: %s....",FILENAME);
	#`DLY_1;
  signal_FILE = $fopen(FILENAME,"wb");
  signal_FILE1 = $fopen(signal_NAME,"wb");
  if (signal_FILE ==0||signal_FILE1==0)
    begin
      $display("Error at opening file: %s or  %s",FILENAME,signal_NAME);
      $stop;
    end
  else
  	$display("writing %s .........",FILENAME);
  end

  always @(posedge clk) begin
    signal_isNotFirstRise <=  #`DLY_1 1;
  end

reg [9:0] cnt=0;  
always @(posedge clk)
  if(enable) begin
    if(cnt==repeat_time-1)
      cnt<=0;
    else 
      cnt<=cnt+1;
  end

//-- Apply Input Vectors -----

  always@(posedge clk) 
  begin 
    if(signal_isNotFirstRise) begin
      if(enable&&cnt==repeat_time-1)
      begin
          $fwrite(signal_FILE, "%s[%d] is %d\n",signal_NAME,index,signal_out);
          $fwrite(signal_FILE1, "%d\n",signal_out);
      	  if(display_OK)begin
	         #delay	$display("Write %s[%d] is %d",signal_NAME,index,signal_out);
          end
          index<=index+1;
 	    end
    end
  end


endmodule
