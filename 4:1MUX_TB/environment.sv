`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;
  driver drv;
  generator gend;
  monitor mont;
  ref_monitor ref_mont;
  scoreboard scbd;
  
  virtual mux_intf vif;
  mailbox m1,m2,m3;
  
  function new (virtual mux_intf vif_c);
    vif  = vif_c;
    m1   = new();
    m2   = new();
    m3   = new();
    drv  = new(m1,vif);
    gend = new(m1);
    mont = new(m2,vif);
    ref_mont = new(m3,vif);
    scbd = new( m2,m3);
  endfunction
  
  task start_p();
    gend.ev1= drv.ev1;
    fork
      gend.gen2drv();
      drv.drv_f_gen();
      mont.sample_data();
      ref_mont.ref_mont_check();
      scbd.collector();
    join
    
  endtask
  
endclass
