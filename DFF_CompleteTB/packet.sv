// Packet class

class packet;
  
  rand bit [7:0] inp;
  bit [7:0] prev_inp;
  
  constraint valid{
    inp inside {[0:10]};
  }
  
  constraint vaild2{
    inp != prev_inp; 
  }
  
  function void post_randomize();
    prev_inp = inp;
  endfunction
  
    function void copy(packet A);
    inp = A.inp;
  endfunction
  
endclass
