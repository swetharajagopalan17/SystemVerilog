class generator;
  //what to randomize 
  transaction trans;
  //putting via mbx 
  mailbox m1;
  //event for synchronization
  event e1;
  
  //whatever we need from outside can be passed in here 
  //trans generated within gen so no need to pass as arg 
  function new(mailbox mbx);
    m1 = mbx;
    trans = new();
  endfunction
  
  //Note: 
  //running stimulus - delay-related --> need a task 
  //functions cannot hold time or delay 
  
  //gen2drv synchronization needs delay so we should use a task 
  task run();
    //10 transactions
    repeat(10) begin 
      //If we instantiate here, we will have separate memory every time
      //trans = new();
      void'(trans.randomize());
      $monitor("[GEN: %d] randomized packet: j = %d, k = %d", $time, trans.j, trans.k);
      m1.put(trans);
      //synchronization: can pass in vif into new and use vif.clk 
      //can also use event 
      $display("[GEN: %d] put the packet into mailbox", $time);
      @(e1);
    end
  endtask
  
endclass
