class monitor;
  
  transaction trans;
  virtual jk_ff_intf vif_jk_ff;
  
  function new(virtual jk_ff_intf vif_jk_ff);
    this.vif_jk_ff = vif_jk_ff ;
    trans = new();
  endfunction
  
  task sample_data();
    repeat(10) begin
      @(posedge vif_jk_ff.clk);
     trans.j = vif_jk_ff.j;
     trans.k = vif_jk_ff.k;
     trans.qout = vif_jk_ff.qout;   
     $display("[MONITOR] j = %h k = %h q = %h", trans.j, trans.k, trans.qout);
     config_db::mon2sb_mb.put(trans);
    end
  endtask
endclass
