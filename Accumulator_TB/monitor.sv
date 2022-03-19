class monitor;
  transaction tr;
  virtual acc_if ac_if;
  mailbox mbx;
  extern function new(mailbox mbx,input virtual acc_if ac_if);
  extern task run();
  extern task wrap_up();  
endclass
    
    function monitor::new(mailbox mbx,input virtual acc_if ac_if);
      this.mbx = mbx;
      this.ac_if = ac_if;      
      tr = new();
    endfunction
      
    task monitor::run();
      wait(ac_if.rst); //wait for reset assertion
      wait(!ac_if.rst); //wait for reset de-assertion
      
      forever begin
      //sampling the DUT output into a transaction
      @(posedge ac_if.clk)
      tr.sum = ac_if.sum;
        $display("At time = %t,Display from Monitor: sampled the dut op",$stime);
      //sending the received tx to the scoreboard
      mbx.put(tr);
      end
    endtask
    
    task monitor::wrap_up();
      //write any code
    endtask
