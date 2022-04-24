`include "environment.sv"

program test_p(jk_intf vif);
  
  environment env;
  
  //instantiate environment and start execution 
  initial begin
    env = new(vif);
    env.start_p();
  end
  
endprogram
