// Program Block

program pgm_blk(simple_if vif);
  
   parameter pkt_count=10;
  
  reg [7:0] exp_q[$];
  
  int matched, mis_matched;
  
   // Generator and Driver
  initial begin
   vif.inp<=7;
   
    
    // Main Stimulus
    for(int i=0; i <pkt_count;i++) begin // Gerenting
      vif.inp <= i; //Driving
      exp_q.push_back(i);
      @(posedge vif.clk);
    end
    
    repeat(3)@(posedge vif.clk); // Drain time
    
    report();
    
    $finish;
  end
  
  reg [7:0] dut_q;
  
  // Montior
  initial begin
    forever@(vif.out) begin
      dut_q = exp_q.pop_front();
      
      // Scoreboard
      if(dut_q == vif.out) begin
        matched++;
      end
      else begin
        mis_matched++;
        $display("[Error] Exp_q=%0d Dut_q=%0d at time=%0t",dut_q,vif.out,$time);
      end
    end
  end

  // Scoreboard
  function void report();
    $display("*****************************\n");
    if(mis_matched == 0 && matched == pkt_count) begin
      $display("**************Test Passed****************");
    end
    else begin
      $display("[Error]**************Test Failed****************");
    end
    
    $display("Pkt_count=%0d Matched count=%0d Mis_matched=%0d",pkt_count,matched, mis_matched);
    $display("\n*****************************");
  endfunction
  
endprogram
