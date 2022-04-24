class generator ;
  transaction tr;
  mailbox m1;
  event wait_for_drv ;
  
  function new (mailbox m1);
    this.m1 = m1 ;
    tr = new ();
  endfunction
  
  virtual task gen2drv();
    //repeat(50) 
      forever begin
       assert(tr.randomize());
       m1.put(tr);
      $strobe($time,"[Generator] Transaction started Din =%0b ",tr.Din);
      @(wait_for_drv);
    end
  endtask
endclass

class direct_generator extends generator ;
  bit [3:0] data_seq ;
  
  function new (mailbox m1);
    super.new(m1);
  endfunction
  
  virtual task gen2drv();
   // begin
      data_seq=4'b1011 ;
      foreach(data_seq[i])  begin
        tr.Din=data_seq[i];
        m1.put(tr);
        $strobe($time,"[ DIRECT Generator] Transaction started Din =%0b ",tr.Din);
      @(wait_for_drv);
      end
  endtask
endclass

class wrong_pattern extends generator ;
  bit [3:0] data_seq ;
  
  function new (mailbox m1);
    super.new(m1);
  endfunction
  
  virtual task gen2drv();
   // begin
      data_seq=4'b1010 ;
      foreach(data_seq[i])  begin
        tr.Din=data_seq[i];
        m1.put(tr);
        $strobe($time,"[ wrong pattern Generator] Transaction started Din =%0b ",tr.Din);
      @(wait_for_drv);
      end
  endtask
endclass
        
        
        
        
        
        
  
    
