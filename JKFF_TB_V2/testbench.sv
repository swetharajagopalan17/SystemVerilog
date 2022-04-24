// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "test.sv"
module tb;
  bit clk;
  
  jk_ff_intf intf(clk);
  jk_ff dut_f (.j(intf.j),.k(intf.k),.clk(intf.clk),.q(intf.qout));
  test_f tf(intf);
  
  always #10 clk = ~clk;
  
  initial begin
    clk = 0;
    #1000 
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
    
endmodule
