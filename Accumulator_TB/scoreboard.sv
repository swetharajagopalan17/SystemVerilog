class scoreboard;
  int exp_sum; //to calculate expected sum from the driver output values
  transaction tr_in, tr_out;
  mailbox mbx_drv, mbx_mon;
  
  covergroup cov;
    c1: coverpoint tr_in.in {
      bins b0 = {[0:15]};
      bins b1 = {[16:31]};
      bins b2 = {[32:47]};
      bins b3 = {[48:63]};
      
      bins b4 = {[64:79]};
      bins b5 = {[80:95]};
      bins b6 = {[96:111]};
      bins b7 = {[112:127]};
      
      bins b8 = {[128:143]};
      bins b9 = {[144:159]};
      bins b10 = {[160:175]};
      bins b11 = {[176:191]};
      
      bins b12 = {[192:207]};
      bins b13 = {[208:223]};
      bins b14 = {[224:239]};
      bins b15 = {[240:255]};
      
    }
  endgroup
  extern function new(mailbox mbx_drv, mbx_mon);
  extern task run();
  extern task wrap_up();  
endclass
    
    function scoreboard::new(mailbox mbx_drv, mbx_mon);
      this.mbx_drv = mbx_drv;
      this.mbx_mon = mbx_mon;
      this.exp_sum = 0;
      tr_in = new();
      tr_out = new();
      cov = new();
    endfunction
      
    task scoreboard::run();
      forever begin
      mbx_drv.get(tr_in);
      mbx_mon.get(tr_out);
      
      if(exp_sum > 65535)
        exp_sum = 65535;
      
         exp_sum += tr_in.in;
        
      if(exp_sum == tr_out.sum)
        $display("Display from scoreboard: exp_sum = %d, monitor sum = %d", exp_sum, tr_out.sum);
      else
        $error("At time = %t,Display from scoreboard: failed exp_sum = %d, monitor sum = %d", $stime,exp_sum, tr_out.sum);
      
     
      end
    endtask
    
    task scoreboard::wrap_up();
      cov.sample();
    endtask
