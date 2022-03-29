// Drive class
class driver;
  
  packet pkt;
  mailbox #(packet) mbx;
  
  bit [7:0] pkt_count;
  virtual simple_if.tb vif; // Null
  
  function new(input mailbox #(packet) mbx_inp,input virtual simple_if.tb aif);
    mbx = mbx_inp;
    vif = aif;
  endfunction
  
  task run();
    forever begin
      mbx.get(pkt);
      @(vif.cb);
      vif.cb.inp <= pkt.inp;
      pkt_count++;
      $display("[Drv] Received Transaction  %0d inp = %0d at time = %0t",pkt_count,pkt.inp,$time);
    end
  endtask
  
endclass
