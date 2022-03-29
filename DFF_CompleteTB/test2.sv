// Test 2 with new_packet

class test2;
  
  environment env;
  
  new_packet n_pkt;
  
  virtual simple_if.tb eif; // Driver
  virtual simple_if.tb_iMon iMif; // iMonitor
  virtual simple_if.tb_oMon oMif; // omonitor
  
  bit [15:0] pkt_count;
  
  function new(input virtual simple_if.tb aif,input virtual simple_if.tb_iMon Mif,input virtual simple_if.tb_oMon o_Mif);
    eif = aif;
    iMif = Mif;
    oMif = o_Mif;
  endfunction
  
  function void build();
  	pkt_count = 40;
    
    env = new(eif,iMif,oMif,pkt_count);
    env.build();
    n_pkt=new;
    env.gen.ref_pkt = n_pkt; // case of new stimulus generation
  endfunction
  
  task run();
    build();
    env.run();
    env.results();
  endtask
  
endclass
