class transaction;
  rand bit [7:0]in; 
  bit [15:0] sum;
endclass

class generator;
  transaction tr1, tr2;
  mailbox mbx, rtn;
  extern function new(mailbox mbx,rtn);
  extern task run();
  extern task wrap_up();
endclass  
  
    function generator::new(mailbox mbx,rtn);
      this.mbx = mbx;
      this.rtn = rtn;
    endfunction
      
    task generator::run();
      
      forever begin
      tr1 = new();
        tr1.randomize() with {tr1.in > 200;};
      
      //sending transaction to driver
      mbx.put(tr1);
        $display("At time = %t,Display from generator:Sending tx to driver",$stime);
      //receiving ack from driver
      tr2 = new();
      rtn.get(tr2);
      
      if(tr1.in == tr2.in)
        $display("At time = %t,Display from generator:ACK MATCHES",$stime);
      else
        $error("Display from generator: Mismtach between generator and driver");
      end
    endtask
    
    task generator::wrap_up();
      //write any code
    endtask
