// Environment Class

class environment;
  
  // Step 1 : Encapsulate all the components
  mailbox #(packet) top_mbx;
  mailbox #(packet) iMon_scb; // Input Monitor to Scoreboard
  mailbox #(packet) oMon_scb; // output Monitor to Scoreboard
  
  driver drv;
  generator gen;
  iMonitor iMon;
  oMonitor oMon;
  scoreboard scb;
  
  bit[15:0] pkt_count;
  
  virtual simple_if.tb_iMon mif; // iMonitor
   virtual simple_if.tb_oMon omif; // oMonitor
  virtual simple_if.tb eif; // Driver
  
  function new(input virtual simple_if.tb aif,virtual simple_if.tb_iMon Mif,virtual simple_if.tb_oMon oMif, bit [15:0] cnt);
    eif = aif;
    mif = Mif;
    omif = oMif;
    pkt_count = cnt;
  endfunction
  
  // Step 2: Construct and Connect components
  function void build();
  	top_mbx=new();
    iMon_scb=new();
    oMon_scb=new();
    gen = new(top_mbx,pkt_count);
    drv=new(top_mbx,eif);
    iMon=new(mif,iMon_scb);
    oMon=new(omif,oMon_scb);
    scb = new(iMon_scb,oMon_scb);
  endfunction
  
  // Step 3: Run component
  task run();
    gen.run();
    
    fork
      drv.run();
      iMon.run();
      oMon.run();
      scb.run();
      wait(pkt_count == scb.pkt_count); // Test termination criteria
    join_any
  endtask
  
  function void results();
    bit [15:0] top_pkt_count;
    top_pkt_count = scb.matched + scb.mis_matched;
    
    $display("\n************************************");
    if((scb.mis_matched == 0) && (scb.matched == pkt_count) && (top_pkt_count == pkt_count)) begin
      $display("[Info] *************Test Passed*************");
      $display("[Info] pkt_count = %0d Matched=%0d Mis_matched=%0d",pkt_count,scb.matched,scb.mis_matched);
    end
    else
       begin
         $display("[Fatal] ****************Test Failed*****************");
         $display("[Info] pkt_count = %0d Matched=%0d Mis_matched=%0d",pkt_count,scb.matched,scb.mis_matched);
       end
    $display("************************************\n");
  endfunction
  
endclass
