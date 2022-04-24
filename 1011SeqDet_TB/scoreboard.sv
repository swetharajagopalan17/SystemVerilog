class scoreboard;
  transaction tr_que[$];
  transaction tr,tr1;
  mailbox m2;
  bit[3:0] din_seq_val;
  
  function new (mailbox m2);
    this.m2 = m2 ;
  endfunction
  
  task scoreboard_checks ();
    //repeat(5) begin 
     forever begin
      m2.get(tr);
      tr_que.push_back(tr);
      wait(tr_que.size() > 0);
      tr1 = tr_que.pop_front;
      checker_data(tr);
    end
  endtask
 
  task checker_data (transaction tr);
   
    din_seq_val = {din_seq_val[2:0],tr.Din};
    
    //din_seq_val = din_seq_val << 1;
     //din_seq_val[0] =  tr.Din ;
    $display($time,"[scoreboard checker ] tr.Din=%0b ,din_seq_val =%0b ",tr.Din,din_seq_val);
    
    if( din_seq_val == 4'b1011 ) begin
      if ( tr.dout == 1 )
        $display($time,"[scoreboard checker ] Sucessfully din_seq_val =%0b tr.dout=%0b",din_seq_val,tr.dout);
    else
      $error("Failed");
    end
    else begin
      
      if( din_seq_val != 4'b1011 && tr.dout == 0) begin 
        $display($time,"[scoreboard] For differnt pattern din_seq %0b != 1011 dout should be low dout=%0d",din_seq_val,tr.dout);
      end
    
      else
        $error("Not expecting dout high dout %0d Failed",tr.dout); 
    end
   endtask
 endclass
             
      
      
    
    
    
    
      
      
      
