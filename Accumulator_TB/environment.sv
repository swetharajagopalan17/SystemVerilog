class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;
  mailbox gen2drv, drv2gen, mon2scb, drv2scb;
  virtual acc_if ac_if;
  extern function new(input virtual acc_if ac_if);
    extern virtual function void build();
  extern task run();
  extern task wrap_up();  
endclass
    
    function environment::new(input virtual acc_if ac_if);
      this.ac_if = ac_if;
    endfunction
    
    function void environment::build();
      gen2drv = new();  
      drv2gen = new(); 
      mon2scb = new(); 
      drv2scb = new(); 
      gen = new(gen2drv, drv2gen);
      drv = new(gen2drv, drv2gen, drv2scb, ac_if);
      mon = new(mon2scb, ac_if);
      scb = new(drv2scb, mon2scb);      
    endfunction
    
    task environment::run();
      fork
      	gen.run();
      	drv.run();
      	mon.run();
      	scb.run();
      join_none
    endtask
    
    task environment::wrap_up();
     fork
      	gen.wrap_up();
      	drv.wrap_up();
      	mon.wrap_up();
      	scb.wrap_up();
      join
    endtask
