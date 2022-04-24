// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "test.sv"

module tb ;

  
   bit clk ,rst;
  intf_seq vi(clk,rst);
  
  test ti (vi);
  seq_dect s_D (.rst(vi.reset),.clk(vi.clock),.in_d(vi.in_d),.dout(vi.dout));
  
 always #5 clk = ~clk;
  
  initial begin 
    #10 rst = 1;
    #1000 $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  
endmodule
   
      
  
