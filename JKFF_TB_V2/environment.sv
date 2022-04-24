`include "transaction.sv"
`include "config_db.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;
  driver drv;
  generator gen;
  monitor mon;
  scoreboard scbd;
  
  virtual jk_ff_intf vif_jk_ff;
  
  function new (virtual jk_ff_intf vif_jk_ff);
    this.vif_jk_ff  = vif_jk_ff;
    drv  = new(vif_jk_ff);
    gen = new();
    mon = new(vif_jk_ff);
    scbd = new();
  endfunction
  
  task start_p();
    gen.ev1= drv.ev1;
    fork
      gen.gen2driv();
      drv.drv2dut();
      mon.sample_data();
      scbd.collector();
    join
    
  endtask
  
endclass
