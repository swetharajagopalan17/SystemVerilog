// Program block

program pgm_blk_test(simple_if vif);
  
//  test test_obj;
  test2 test_obj;
  
  // Apply stimulus
  initial begin
    test_obj = new(vif.tb,vif.tb_iMon,vif.tb_oMon);
    test_obj.run();
    
    $finish;
  end
  

endprogram
