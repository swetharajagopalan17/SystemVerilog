`include "environment.sv"

program test_f ( jk_ff_intf vif );
  
  environment eve;
  
  initial begin
    eve = new(vif);
    eve.start_p();
  end
  
endprogram
