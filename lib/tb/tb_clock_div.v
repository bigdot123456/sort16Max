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

module tb_clock_div (clk_in, rst, clk_out); 
  parameter cfactor= 2;
  input clk_in;
  input rst;
  output clk_out;
	reg clk_loc=0; 
//	reg [15:0] cnt;//allowed maximum clock division factor is 65536
	reg [10:0] cnt;//allowed maximum clock division factor is 2048
  
//  assign clk_out = ((rst==1) || (cfactor==1))? clk_in : clk_loc;
  
  assign clk_out = (cfactor==1)? clk_in : clk_loc;
  
  always@(posedge clk_in)
  begin: cdiv
      if(rst==1)
        begin
          cnt <= 'd0;
          clk_loc = 1;
        end
      else
        begin
          cnt <= cnt + 1'b1;
          if(cnt==cfactor/2-1) 
            clk_loc = 0;
          else if(cnt==cfactor-1) 
            begin
              cnt <= 'd0;
              clk_loc = 1;
            end
        end
  end
endmodule

