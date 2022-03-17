// DFF
module dff(clk,inp,out);
  input clk;
  input [7:0] inp;
  output reg [7:0] out;
  
  always@(posedge clk) begin
    out <= inp;
  end
  
endmodule
