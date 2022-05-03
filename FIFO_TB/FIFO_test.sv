//filename:- FIFO_test.sv
program test(FIFO_intf intf);
  initial begin
    FIFO_env env;
     env =new();
    
     if($test$plusargs("fifo_wr_test"))
       begin
       env.gen = env.wr_gen;
         $display("Sequence 0 is assigned");
       end
     else if($test$plusargs("fifo_wr_rd_sequential_test"))
       begin
         env.gen = env.wr_rd_sequential_gen;
         $display("Sequence 1 is assigned");
       end
    else if ($test$plusargs("new_test"))
      begin
        env.gen = env.wr_rd_sequential_gen_2;
        $display("Sequence 2 is assigned");
      end
   
    env.run(intf);
  end
endprogram
