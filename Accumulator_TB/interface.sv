interface acc_if(input bit clk);
  logic  [15:0]	sum;
  logic  [7:0]  in;
  logic rst;
  
  clocking cb @(posedge clk);
    default input #1 output #1;
    
    output in, rst;
    input sum;
  endclocking
    
  modport dut(input rst,
             input in,
             output sum);
  
  modport test(output rst,
              output in,
              input sum);
  
endinterface
