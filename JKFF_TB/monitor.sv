class monitor;
  //what to randomize 
  transaction trans;
  //putting via mbx 
  mailbox m2;
  //virtual interface for connection
  virtual jk_intf vif;
  
  function new(mailbox mbx, virtual jk_intf vintf);
    m2 = mbx;
    vif = vintf;
    trans = new();
  endfunction
  
  task run();
    repeat(10) begin
      //wait for signals to change 
      //@(vif.j or vif.k);
      @(posedge vif.clk);
      //monitor should sample everything 
      trans.j = vif.j;
      trans.k = vif.k;
      trans.q = vif.q;
      $monitor("[MON] At time %d, j = %d and k = %d", $time, vif.j, vif.k);
      //$monitor($time,"[monitor] sampled datas  %s",trans.print());
      //second mailbox --> mon2scb 
      m2.put(trans);
    end
  endtask
endclass

//Can directly compare values in scb w/o ref_monitor 
class ref_monitor;
  //what to randomize 
  transaction trans;
  //putting via mbx 
  mailbox m3;
  //virtual interface for connection
  virtual jk_intf vif;
  
  function new(mailbox mbx, virtual jk_intf vintf);
    m3 = mbx;
    vif = vintf;
    trans = new();
  endfunction
  
  task run();
    repeat(10) begin
      //wait for signals to change 
      //@(vif.j or vif.k);
      //delay should be clock edge because jkff is seq block
      @(posedge vif.clk);
      case({vif.j,vif.k})
      	2'b00 :  trans.q = trans.q;
      	2'b01 :  trans.q = 0;
      	2'b10 :  trans.q = 1;
      	2'b11 :  trans.q = ~trans.q;
      endcase
      //third mailbox --> ref_mon2scb 
      //tr4.j and tr4.k are 0 because we're not passing vif values to the transaction object
      m3.put(trans);
    end
  endtask
endclass
