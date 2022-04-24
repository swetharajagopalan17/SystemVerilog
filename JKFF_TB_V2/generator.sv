class generator;
  
  transaction trans;
  event ev1;
  
  function new;
    trans = new();
  endfunction
  
  task gen2driv();
    repeat(10) begin
    void'(trans.randomize());
      $display("[GENERATOR] j = %h k = %h", trans.j, trans.k);
      //static mailboxes 
    config_db::gen2driv_mb.put(trans);
    @(ev1);
    end
  endtask
  
  
endclass
