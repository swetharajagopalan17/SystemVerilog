class driver;
  
  transaction trans;
  mailbox m1;
  event ev1; 
  virtual mux_intf vif_d;
  
  function new( mailbox m_c,virtual mux_intf vif_c);
    vif_d = vif_c ;
    m1=m_c;
    trans = new();
  endfunction
  
  task drv_f_gen();
    
    repeat(50) begin
    m1.get(trans);
    vif_d.din_0 <= trans.din_0;
    vif_d.din_1 <= trans.din_1;
    vif_d.din_2 <= trans.din_2;
    vif_d.din_3 <= trans.din_3;
    vif_d.sel <= trans.sel;
    $monitor("[DRIVER] Transaction convert to object to pin level din_0 = %0d ,din_1 = %0d ,din_2 = %0d ,din_3 = %0d, and sel =%0d",vif_d.din_0,vif_d.din_1,vif_d.din_2,vif_d.din_3,vif_d.sel);
      #5;
    ->ev1;
    end
  endtask
  
endclass
