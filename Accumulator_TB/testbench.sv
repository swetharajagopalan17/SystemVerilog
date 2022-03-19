`include "interface.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

module tb_top;
  
  bit tb_clk;
  
  //Generation of clock signal
  always #10 tb_clk = ~tb_clk;
  
  //interface instance
  acc_if ac_if(.clk(tb_clk));
  
  //DUT instance
  accumulator DUT(.sum(ac_if.sum), .in(ac_if.in), .rst(ac_if.rst), .clk(tb_clk)); 
  
  test tst(ac_if);
  
  initial
 	begin
      $dumpfile("accumlator2.vcd");
      $dumpvars;
    end
  
endmodule

