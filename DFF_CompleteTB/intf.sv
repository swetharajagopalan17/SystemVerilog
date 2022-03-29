// Interface

interface simple_if (input clk);
  
  logic [7:0] inp, outp;
  
  clocking cb@(posedge clk); // Driver
    output inp;  	// From TB
  endclocking
  
  clocking cb_iMon@(posedge clk); // iMon
    input inp;
  endclocking
  
  clocking cb_oMon@(posedge clk); // oMon
    input outp;
  endclocking
  
  modport tb (clocking cb);
    modport tb_iMon(clocking cb_iMon);
      modport tb_oMon(clocking cb_oMon);
  
endinterface
