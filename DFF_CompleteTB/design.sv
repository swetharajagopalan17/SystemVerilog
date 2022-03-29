// Code your design here
module dut(clk,inp,outp);
  
  input clk;
  input [7:0] inp;
  output reg [7:0] outp;
  
  always@(posedge clk) begin
  //  if(inp == 135)
  //    	outp <= inp + 1;
  //  else
      outp <= inp;
  end
  
endmodule

// Transaction Level: High level of abstraction
// Pin Level : Low Level of abstraction

// Driver : Converts transation level to pin (Inputs) level.
// Monitor: Converts pin level activity to transaction level
// Environment : Container class
