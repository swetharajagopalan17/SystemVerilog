// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "test.sv"
module tb;
 
  mux_intf intf();
  mux_4_1 dut_f (intf.sel,intf.y,intf.din_0,intf.din_1,intf.din_2,intf.din_3);
  test_f tf(intf);

 
  initial begin
    #1000 
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
    
endmodule
