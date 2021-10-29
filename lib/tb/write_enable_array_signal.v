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
//write_enable_array_signal #(8,256,16,"bit256_AGC_I.dat","bit256_AGC_I",1,1,1)U_DATA_I(.clk(clk_36M ),.enable (`fc_core.en_bit_fc),.signal_out (`fc_core.bit256_AGC_I[0]));

`define DLY_1 1
module write_enable_array_signal
#(
parameter signal_WIDTH=10,
parameter len=256,
parameter view_len=16,
parameter FILENAME="array.dat",
parameter signal_NAME="array",
parameter repeat_time=1,
parameter delay=2,
parameter display_OK=0,
parameter display_index=0
)
(
input clk,
input enable,
input signed [len*signal_WIDTH-1:0] signal_out
);

integer signal_FILE,signal_FILE1;
integer index=0;
integer index1=0;
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

wire signed [signal_WIDTH-1:0]signal[len-1:0];
genvar m;
generate 
  for(m=0;m<len;m=m+1) begin :loop
    assign signal[m]=signal_out[(m+1)*signal_WIDTH-1:m*signal_WIDTH];
  end
endgenerate

//-- Apply Input Vectors -----
integer i;

  always@(posedge clk)
  begin
    if(signal_isNotFirstRise) begin
      if(enable&&cnt==repeat_time-1)
      begin
        if(signal_WIDTH==1)begin
           for(i=0;i<view_len;i=i+1)begin
            if(!display_index)
              $fwrite(signal_FILE, "%s[%d] is %b\n",signal_NAME,index,signal[i]);
            else
              $fwrite(signal_FILE, "%s[%d][%d] is %b\n",signal_NAME,index1,i,signal[i]);
            
            $fwrite(signal_FILE1, "%b\n",signal[i]);
        	  if(display_OK)
          	$display("Write %s[%d] is %b",signal_NAME,index,signal[i]);
            index<=index+1;
        	end
        	index1<=index1+1;
        end else begin 
           for(i=0;i<view_len;i=i+1)begin
            if(!display_index)
              $fwrite(signal_FILE, "%s[%d] is %d\n",signal_NAME,index,signal[i]);
            else
              $fwrite(signal_FILE, "%s[%d][%d] is %d\n",signal_NAME,index1,i,signal[i]);
            
            $fwrite(signal_FILE1, "%d\n",signal[i]);
        	  
        	  if(display_OK)
          	  #delay $display("Write %s[%d] is %d",signal_NAME,index,signal[i]);
            
            index<=index+1;
        	end
          index1<=index1+1;
        end 
 	    end
    end
  end

endmodule
