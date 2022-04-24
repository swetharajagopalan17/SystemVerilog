class scoreboard;
  //4: 2 for popping and 2 for pushing into queue
  transaction tr1,tr2 ,tr3,tr4;
  //2 queues
  transaction tr1_qu[$] , tr2_qu[$] ;
  //2 mailboxes: from mon and ref_mon
  mailbox mon2sb, ref_mon2sb;
  
  function new(mailbox m1, mailbox m2);
    mon2sb = m1;
    ref_mon2sb = m2;  
    tr3 = new();
    tr4 = new();
  endfunction
  
  task collector();
    repeat(10) begin
    	mon2sb.get(tr1);
    	ref_mon2sb.get(tr2);
    	tr1_qu.push_back(tr1);
    	tr2_qu.push_back(tr2);
    	compare_val();
    end
  endtask
  
  task compare_val();
     tr3 = tr1_qu.pop_front;
     tr4 = tr2_qu.pop_front;
    if(tr3.q == tr4.q) begin
      $display();
      $display($time,"[scoreboard] sucessfully compared [tr3.j =%0d ,tr3.k = %0d, tr3.q =%0d] == [tr4.j =%0d ,tr4.k = %0d,tr4.q= %0d]" ,tr3.j, tr3.k, tr3.q, tr4.j, tr4.k, tr4.q);
    end
    else begin
      $error("[scoreboard] compare failed: tr3.q =%0d , tr4.q= %0d" ,tr3.q,tr4.q);
     end
  endtask
  
endclass
