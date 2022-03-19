class driver;
  transaction tr;
  virtual acc_if ac_if;
  mailbox mbx, rtn, mbx_scb;
  extern function new(mailbox mbx,rtn,mbx_scb,input virtual acc_if ac_if);
  extern task run();
  extern task wrap_up();  
endclass
    
    function driver::new(mailbox mbx,rtn,mbx_scb,input virtual acc_if ac_if);
      this.mbx = mbx;
      this.rtn = rtn;
      this.mbx_scb = mbx_scb;
      this.ac_if = ac_if;      
      tr = new();
    endfunction
      
    task driver::run();
      //driving reset using interface
      @(negedge ac_if.clk);
      ac_if.rst = 1;
      
      @(negedge ac_if.clk);
      ac_if.rst = 0;
      
      forever begin
      //getting the transaction from generator
      mbx.get(tr);
        $display ("At time= %t,Display from driver: reveive trx",$stime);
      //sending ack to generator
      rtn.put(tr);
      
      //sending transaction to scoreboard
      mbx_scb.put(tr);
      
      //driving in port of DUT through interface
      ac_if.in = tr.in;
      
        @(posedge ac_if.clk);
      end
      
    endtask
    
    task driver::wrap_up();
      wait(ac_if.sum == 16'hFFFF);
      //@(posedge ac_if.clk);
      $display("display from driver: FINISHING SIMULATION");
      
      $finish;
    endtask
