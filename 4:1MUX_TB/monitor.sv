class monitor;
  
  transaction trans;
  mailbox m2;
  virtual mux_intf vif_d;
  
  function new( mailbox m_c,virtual mux_intf vif_c);
    vif_d = vif_c ;
    m2=m_c;
    trans = new();
  endfunction
  
  task sample_data();
    repeat(50) begin
    @(vif_d.din_0 or vif_d.din_1 or vif_d.din_2 or vif_d.din_3 or       vif_d.sel);
     trans.din_0 = vif_d.din_0 ;
     trans.din_1 = vif_d.din_1 ;
     trans.din_2 = vif_d.din_2 ;
     trans.din_3 = vif_d.din_3 ;
     trans.sel   = vif_d.sel ;
     trans.y = vif_d.y;
      $monitor($time,"[monitor] sampled datas  %s",trans.print());
    m2.put(trans);
    end
  endtask
endclass

class ref_monitor;
  
  transaction trans;
  mailbox m3;
  virtual mux_intf vif_d;
  
  function new( mailbox m_c,virtual mux_intf vif_c);
    vif_d = vif_c ;
    m3=m_c;
    trans = new();
  endfunction
  
  task ref_mont_check();
    repeat(50) begin
   @(vif_d.din_0 or vif_d.din_1 or vif_d.din_2 or vif_d.din_3 or       vif_d.sel); 
    
    case (vif_d.sel)
      0 : trans.y = vif_d.din_0;
      1 : trans.y = vif_d.din_1;
      2 : trans.y = vif_d.din_2;
      3 : trans.y = vif_d.din_3;
    endcase
    m3.put(trans);
    end
  endtask
    
endclass
