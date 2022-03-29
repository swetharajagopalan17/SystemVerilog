// oMonitor class

class oMonitor;
  
  virtual simple_if.tb_oMon vif;
    packet pkt;
  mailbox #(packet) mbx;
  
  bit [15:0] pkt_count; 
  
  function new(input virtual simple_if.tb_oMon aif, input mailbox #(packet) mbx_inp);
    vif = aif;
    mbx = mbx_inp;
  endfunction
  
  task run();
    forever begin
      @(vif.cb_oMon.outp);
      $display("[oMon] Detected inp=%0d at time=%0t",vif.cb_oMon.outp,$time);
      pkt = new; // Construct transaction
      pkt.inp = vif.cb_oMon.outp; // Convert pin level to transaction level
      mbx.put(pkt); // Sending transaction to Scoreboard
      
      pkt_count++;
      $display("[oMon] Sent transaction %0d to scoreboard at time = %0t",pkt_count,$time);
    end
  endtask
  
endclass
