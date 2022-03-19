program automatic test(acc_if ac_if);
  
  environment env;
  initial
    begin
      env = new(ac_if);
      env.build();
      env.run();
      env.wrap_up(); 
    //  cov.sample();
    end
endprogram
