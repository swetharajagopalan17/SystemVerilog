// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples

`include "intf.sv"
`include "packet.sv"
`include "new_packet.sv"
`include "generator.sv"
`include "driver.sv"
`include "iMonitor.sv"
`include "oMonitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
`include "test2.sv"
`include "pgm_blk.sv"
module top;
  
  bit clk;
  
  always #5 clk = ~clk;
  
  simple_if intf_inst(clk);
  
  dut DFF(
    .clk(clk),
    .inp(intf_inst.inp),
    .outp(intf_inst.outp)
  );
  
  pgm_blk_test tb_inst(intf_inst);
  
  
  
endmodule
