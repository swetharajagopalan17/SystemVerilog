
`include "intf.sv"

`include "pgm_blk.sv"

module top;
  
  bit clk;
  
  simple_if intf_inst(clk);
  
    always #5 clk = ~clk;
  
  dff DUT(.clk(clk),.inp(intf_inst.inp),.out(intf_inst.out));
   
  pgm_blk pgm_blk_inst(intf_inst.tb);
  
endmodule
