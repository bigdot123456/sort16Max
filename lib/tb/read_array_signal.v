/* *******************                    read array data module ******************* */
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
`define DLY_1 1

//read_array_signal#(.BIT_W(10),.len(256),.FILENAME("../../pat/dsss/i.dat"),.offset(0))(.sig_out(sig_out));

module read_array_signal#(
parameter BIT_W=10,
parameter len=256,
parameter FILENAME="../../pat/dsss/i.dat",
parameter offset=0
)(
	output [BIT_W*len-1:0] sig_out
);
integer signal_FILE; 
integer i,cnt;
reg signed [BIT_W-1:0]  mem[len-1:0];
initial	begin
  $display("reading: %s....",FILENAME);
	#`DLY_1;
  signal_FILE = $fopen(FILENAME,"rb");
  if (signal_FILE ==0) begin
      $display("Error at opening file: %s",FILENAME);
      $stop;
  end

	for(i=0;i<offset;i=i+1)begin
  	if(!$feof(signal_FILE))
  	 cnt=$fscanf(signal_FILE, "%d\n", mem[0]); //unused signal
	end	
	for(i=0;i<len;i=i+1)begin
  	if(!$feof(signal_FILE))
  	 cnt=$fscanf(signal_FILE, "%d\n", mem[i]); //unused signal
	end	
end

genvar n;
generate
	for(n=0;n<256;n=n+1)begin
		assign sig_out[(n+1)*BIT_W-1:n*BIT_W]=mem[n];
	end
endgenerate

endmodule

`undef DLY_1
