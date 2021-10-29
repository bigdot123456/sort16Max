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
// read_enable_signal  #(15,"i.dat",2*9,1,1,0) U_read_enable_I(.clk(clk_RF ),.enable (rx_en),.signal_out (data_I));
`define DLY_1 1
module read_enable_signal
#(
parameter signal_WIDTH=10,
parameter FILENAME="./pat/dfai.dat",
parameter repeat_time=1,
parameter delay=2,
parameter repeat_rand=0,
parameter display_OK=0
)
(
input clk,
input enable,
output signed [signal_WIDTH-1:0] signal_out
);

reg signed [signal_WIDTH-1:0] signal_data=0;

integer signal_FILE; 

reg signal_isNotFirstRise = 0;
reg signal_isSimulationEnd= 0;
reg signed [signal_WIDTH-1:0] tmp_sig_I=0;
integer index=0;
	
	initial
	begin
  $display("reading: %s....",FILENAME);
	index=0;
	#`DLY_1;
  signal_FILE = $fopen(FILENAME,"rb");
  if (signal_FILE ==0)
    begin
      $display("Error at opening file: %s",FILENAME);
      $stop;
    end
  else
  	$display("Loading %s .........",FILENAME);
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
      if ($feof(signal_FILE) != 0)
      begin
        signal_isSimulationEnd = 1;  
				#`LAST_TIME;
        $finish(2);
      end
      else 
      if(enable&&cnt==repeat_time-1)
      begin
        #delay;
        index=index+1;
      	if ($fscanf(signal_FILE, "%d\n", tmp_sig_I)<1)
	      begin
	        signal_isSimulationEnd = 1;  
	        #`LAST_TIME;
	        $finish(2);
	      end
	      else
       	begin
          if(display_OK)
          	$display("%s[%d] is %d",FILENAME,index,tmp_sig_I);
          
          signal_data <=  #`DLY_1 tmp_sig_I;
        end
 	    end
    end
  end

reg signed [4:0] rnd_data=0;
always@(posedge clk)
  if(enable)begin
    if(repeat_rand) 
      rnd_data<=$random % 60;
    else
      rnd_data<=0;
  end 

assign signal_out= signal_data+rnd_data;

endmodule
