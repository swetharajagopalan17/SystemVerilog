class monitor ;
  transaction tr;
  mailbox m2;
  virtual intf_seq vif;
  
  function new (virtual intf_seq vif , mailbox m2);
    this.m2 = m2 ;
    this.vif = vif ;
    tr = new ();
  endfunction
  
 task monitor_sample ();
    // repeat(5) begin
    forever begin     
     @(negedge vif.clock)         
     wait(vif.reset);
      tr.Din = vif.in_d ;
      tr.dout = vif.dout;
    $strobe($time,"[MONITOR] Transaction started Din =%0b dout =%0b ",tr.Din,tr.dout);
      m2.put(tr);
    end
  endtask
endclass
