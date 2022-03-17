// Code your design here

// Code your testbench here
// or browse Examples
module test;
  
  task add_t(input [3:0] in1,in2, output [3:0] out);
    out = in1 + in2;
  endtask
  
  function reg [3:0] add_f(input [3:0] in1,in2);
   // add_f = in1 + in2;
     return (in1 + in2);
  endfunction
  
  logic [3:0] sum_t,sum_f;
  
  initial begin
    add_t(5,5,sum_t);
    $display("Task output sum = %0d",sum_t);   
  end
  
  initial begin
    sum_f = 5 + add_f(5,5);
    $display("Function output sum = %0d",sum_f);
  end
  
endmodule
