// Inteface

interface simple_if (input clk);
  logic [7:0] inp,out;
  
  modport tb(output inp, input out);
  
endinterface
