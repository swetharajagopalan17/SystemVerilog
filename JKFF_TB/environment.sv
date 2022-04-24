`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  driver drv;
  generator gen;
  monitor mont;
  ref_monitor ref_mont;
  scoreboard scbd;
  
  virtual jk_intf vif;
  mailbox m1,m2,m3;
  
  function new (virtual jk_intf vintf);
    vif  = vintf;
    m1   = new();
    m2   = new();
    m3   = new();
    drv  = new(m1,vif);
    gen = new(m1);
    mont = new(m2,vif);
    ref_mont = new(m3,vif);
    scbd = new( m2,m3);
  endfunction
  
  task start_p();
    gen.e1= drv.e1;
    fork
      gen.run();
      drv.run();
      mont.run();
      ref_mont.run();
      scbd.collector();
    join
  endtask
  
endclass
