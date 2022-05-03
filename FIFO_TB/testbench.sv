// system verilog assignment 10

//filename:- testbench.sv
`include "FIFO_lib.sv"
module top;
  logic clk, rst;
  
  
  FIFO_intf intf(clk, rst);
  
  FIFO #(.width(4),
         .depth(16)) DUT(.clk(intf.clk), 
                         .rst(intf.rst), 
                         .r_en(intf.rd_en), 
                         .w_en(intf.wr_en), 
                         .data_in(intf.data_in),
                         .data_out(intf.data_out),
                         .full(intf.full),
                         .empty(intf.empty));
  
  test t(intf);
  
  initial begin
   clk = 0;
   rst = 0;
  #15; rst = 1;
  #200; $finish();
  end 
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars();
  end
endmodule
