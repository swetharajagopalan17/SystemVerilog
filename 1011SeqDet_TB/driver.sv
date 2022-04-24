class driver ;
  transaction tr;
  mailbox m1;
  event wait_for_drv ;
  virtual intf_seq vif;
  
  function new (virtual intf_seq vif , mailbox m1);
    this.m1 = m1 ;
    this.vif = vif ;
    tr = new ();
  endfunction
  
  task driving_to_dut ();
    //repeat(50)
     forever begin
      wait(vif.reset)
      m1.get(tr);
      $strobe($time,"[DRIVER] Transaction started Din =%0b ",tr.Din);
      @(posedge vif.clock)
       vif.in_d <= tr.Din ;
      ->wait_for_drv;
    end
  endtask
endclass
