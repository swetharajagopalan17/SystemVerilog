class transaction ;
  
  rand bit din_0,din_1,din_2,din_3;
  bit y;
  rand bit[1:0] sel;
  
  function string print();
    string datas ;
    $sformat(datas,"din_0 = %0d",din_0);
    $sformat(datas,"%s din_1 = %0d",datas,din_1);
    $sformat(datas,"%s din_2 = %0d",datas,din_2);
    $sformat(datas,"%s din_3 = %0d",datas,din_3);
    $sformat(datas,"%s output y = %0d",datas,y);
    $sformat(datas,"%s sel = %0d",datas,sel);
    return datas;
  endfunction 
endclass
