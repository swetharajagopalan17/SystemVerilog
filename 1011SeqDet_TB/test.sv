`include "environment.sv"
program test  ( intf_seq vi );
  environment env;
  
  initial begin
    env = new(vi);
    if ($test$plusargs("direct")) begin
      env.gen = env.gen_direct ;
      $display("Direct test");
    end
    else if ($test$plusargs("wrong_patrn")) begin
     env.gen = env.wrng_patrn;
      $display("wrong_ptrn");
    end
     env.started ();
  end
endprogram



  
