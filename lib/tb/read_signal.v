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

`define DLY_1 1
module read_signal
#(parameter signal_WIDTH=10,
parameter FILENAME="./pat/dfai.dat",
parameter Bin_or_TXT=1
)
(
input clk,
output reg signed [signal_WIDTH-1:0] signal_out
);


integer signal_FILE; 

reg signal_isNotFirstRise = 0;
reg signal_isSimulationEnd= 0;
reg signed [signal_WIDTH-1:0] tmp_sig_I;
	
	initial
	begin
	signal_out=0;
	#`DLY_1;
  signal_FILE = $fopen(FILENAME,"rb");
  if (signal_FILE ==0)
    begin
      $display("Error at opening file: %s",FILENAME);
      $stop;
    end
  end

  always @(posedge clk) begin
    signal_isNotFirstRise <=  #`DLY_1 1;
  end
	
//	integer status;
integer result;
reg [7:0] fbuf[3:0];
//-- Apply Input Vectors -----
  always@(posedge clk) 
  begin 
    if(signal_isNotFirstRise) begin
      if ($feof(signal_FILE) != 0)
      begin
        signal_isSimulationEnd = 1;  
        $display("Reach File end! Now use  Timeout to finish Simulation!",$time);
        $fclose(signal_FILE);
				#`LAST_TIME;
        $finish(1);
      end
      else
      begin
        if(Bin_or_TXT)begin
             result=$fread( fbuf,signal_FILE );
             tmp_sig_I={fbuf[3],fbuf[2]};
        end else begin
          result=$fscanf(signal_FILE, "%d\n", tmp_sig_I);
        end
      	if (result<1)
        begin
          signal_isSimulationEnd = 1;  
          $display("File Read finish! Now wait finishing!",$time);
          #`LAST_TIME;
          $finish(2);
        end
        else
       	begin
          `ifdef DATA_DEBUG
          	$display("Data is %d",tmp_sig_I);
          `endif
          signal_out <=  #`DLY_1 tmp_sig_I;
        end
      end
    end
  end
endmodule

