class generator;
  
  transaction trans;
  mailbox m1;
  event ev1;
  
  function new( mailbox m_c);
    trans = new();
    m1=m_c;
  endfunction
 
  task gen2drv();
    repeat(50) begin
    void'(trans.randomize());
    $monitor($time,"[generator] Randomizing inputs %s",trans.print());
    m1.put(trans);
    @(ev1);
      wait(ev1.triggered);
    end
  endtask
  
endclass
