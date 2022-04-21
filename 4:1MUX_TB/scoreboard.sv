class scoreboard;
  transaction tr1,tr2 ,tr3,tr4;
  transaction tr1_qu[$] , tr2_qu[$] ;
  mailbox mon2sb, ref_mon2sb ;
  
  function new ( mailbox m1_c , m2_c );
    mon2sb = m1_c;
    ref_mon2sb = m2_c;  
    //tr3 = new();
    //tr4 = new();
  endfunction
  
  task collector();
    repeat(50) begin
    mon2sb.get(tr1);
    ref_mon2sb.get(tr2);
    tr1_qu.push_back(tr1);
    tr2_qu.push_back(tr2);
    compare_val();
    end
  endtask
  
  task compare_val();
     tr3 = tr1_qu.pop_front ;
     tr4 = tr2_qu.pop_front ;
    if(tr3.y == tr4.y) begin
      $display();
      $display($time,"[scoreboard] sucessfully compared tr3.sel =%0d ,tr3.y =%0d == tr4.y= %0d" ,tr3.sel,tr3.y,tr4.y);
    end
    else begin
      $error("[scoreboard] compare failedtr3.y =%0d , tr4.y= %0d" ,tr3.y,tr4.y);
     end
  endtask
  
endclass
