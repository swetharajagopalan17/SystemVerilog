class driver;
  
  transaction trans;
  event ev1; 
  //global variable
  virtual jk_ff_intf vif_jk_ff;
  
  //function variable 
  function new(virtual jk_ff_intf vif_jk_ff);
    this.vif_jk_ff = vif_jk_ff ;
    trans = new();
  endfunction
  
  task drv2dut();
    repeat(10) begin
    @(posedge vif_jk_ff.clk);
    config_db::gen2driv_mb.get(trans);
    vif_jk_ff.j <= trans.j;
    vif_jk_ff.k <= trans.k;
    $display("[DRIVER] j = %h k = %h", trans.j, trans.k);
    ->ev1;
    end
  endtask
  
endclass
