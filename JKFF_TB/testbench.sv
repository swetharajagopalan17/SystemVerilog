// Code your testbench here
// or browse Examples
`include "intf.sv"
`include "test.sv"

module tb_top;
  
  bit clk;
  
  always #5 clk = ~clk;
  
  
  jk_intf intf(clk);
  
  jk_ff dut_f(intf.j,intf.k,clk,intf.q);
  
  test_p tf(intf);

 
  initial begin
    #1000 
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
