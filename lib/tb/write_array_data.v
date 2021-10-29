/* *******************                    write array data module ****************** */
/* **********                                                                     ** */
/* **********                                                                     ** */
/* **********                                                                     ** */
/* **********                                                                     ** */
/* **********                                                                     ** */
/* ***************************************** GS Core ******************************* */

// Create by Mr. Liqinghua
// rev.0.1 2015.10.29
// rev.0.2 2015.10.29

`timescale 1ns/1ps

//write_array_data#(.BIT_W(10),.len(256),.NAME("data"),.FILENAME("result.dat"),.delay(1))(.data(data)) U_data(data);
//write_array_data.write(0);
//write_array_data.write(U_data.cnt);

module write_array_data#(
parameter BIT_W=10,
parameter len=256,
parameter NAME="data",
parameter FILENAME="result.dat",
parameter delay=1
)(
	input [BIT_W*len-1:0] data
);
reg [31:0] cnt=0;
integer signal_FILE,i;
task write;
input integer offset;
begin
    #delay;
    signal_FILE = $fopen(FILENAME,"wb+");
    if (signal_FILE ==0) begin
        $display("Error at opening file: %s",FILENAME);
        $stop;
    end
  
  	for(i=0;i<len;i=i+1)begin
  	  cnt=cnt+1;
      $display ("%gWrite task with address : %h Data : %h",$time, offset+i,data[(i+1)*BIT_W-1:i*BIT_W]);
      $fwrite(signal_FILE, "%s[%d] = %d\n",NAME,offset+i,data[(i+1)*BIT_W-1:i*BIT_W]);
   	end	
   	$fclose(signal_FILE);
  end
  
endtask

endmodule

