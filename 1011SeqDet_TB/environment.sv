`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment ;
  mailbox gen_drv , mon2sbd;
  event wait_for_drv ;
  virtual intf_seq vif;
  generator gen;
  driver  drv;
  monitor  mon;
  scoreboard sbd;
  direct_generator gen_direct ;
  wrong_pattern wrng_patrn;
  
  function new ( virtual intf_seq vif);
    this.vif=vif;
    gen_drv = new();
    mon2sbd = new();
    gen = new(gen_drv);
    drv = new(vif,gen_drv);
    mon = new(vif,mon2sbd);
    sbd = new(mon2sbd);
    gen_direct = new(gen_drv);
    wrng_patrn = new(gen_drv);
  endfunction
  
  task started ();
    gen.wait_for_drv = drv.wait_for_drv;
    fork
      gen.gen2drv();
      drv.driving_to_dut();
      mon.monitor_sample();
      sbd.scoreboard_checks();
    join
  endtask
endclass
      
    
    
    
