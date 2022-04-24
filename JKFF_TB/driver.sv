class driver;
  //contains transaction, mailbox, event 
  //what to randomize 
  transaction trans;
  //putting via mbx 
  mailbox m1;
  //event for synchronization
  event e1;
  //virtual interface for connection
  virtual jk_intf vif;
  
  function new(mailbox mbx, virtual jk_intf vif_g);
    m1 = mbx;
    trans = new();
    vif = vif_g;
  endfunction
  
  task run();
    repeat(10) begin
      //get the transaction from generator
      
      m1.get(trans);
      //packet to pin level activity 
      //delay needed for transaction to be processed 
      @(posedge vif.clk);
      vif.j <= trans.j;
      vif.k <= trans.k;
      $display("[DRV] At time %d, j = %d and k = %d", $time, trans.j, trans.k);
      //$monitor sometimes gives delayed output because it prints at end of timestep
      
      //debug 
      //$monitor("[DRIVER] Transaction convert to object to pin level j = %0d ,k = %0d", vif.j, vif.k);
      //we don't need delay for sequential block
      //#10;
      //Using event is simpler than using clk for gen2drv --> clk needs vif 
      ->e1;
    end
  endtask
  
endclass
