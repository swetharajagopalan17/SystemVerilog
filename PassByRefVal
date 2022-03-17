// Code your testbench here
// or browse Examples
module test;
//ref direction
  task foo(input bit[3:0] a1, ref bit[3:0] out_a3);
    $display("[Task] start of task a1 = %0d at time = %0t",a1,$time);
    
    #2 a1 = 5;
    
    $display("[Task] a1 changed to = %0d at time = %0t",a1,$time);
    
    #2 out_a3 = a1 + 3;
    
    #1 $display("[Task] End of task a1 = %0d out_a3 = %0d at time = %0t",a1,out_a3,$time);
    
  endtask// end of time 5
  
  bit [3:0] i1, out;
  
  initial begin
    i1 = 0; out=0;
    
    foo(i1,out);
    
    $display("[Test] i1 = %0d out = %0d at time = %0t",i1,out,$time);
    
  end
  
  always@(i1) begin
    $display("[Always i1] Detected change on i1 = %0d at time = %0t",i1,$time);
  end
  
  always@(out) begin
    $display("[Always out] Detected change on out = %0d at time = %0t",out,$time);
  end
endmodule
