// Code your design here
// Singleton Object
class A;
 	
  //make err_cnt static for global incrementing
  static int err_cnt;
 
  //make object static to create global reference
  static A obj = get();
  
  static function A get();
    //check that no prior instance exists
    if(obj == null)
      	obj = new;
    
    return obj;
  endfunction
  
  //new should be local so handles outside the class cannot be instantiated
  //join_none fulfills function criteria while spawning task in the background
 local function new();
   fork
   	wait_on_err_count();
   join_none
  endfunction
  
  //print for debug purposes
  //static err_cnt variable will increment 
  function void error_msg(input string str);
    $display("[Error] str = %0s",str);
    err_cnt++;
  endfunction
  
  //only needs to be called once since it has forever begin
  //needs to wait on err_cnt 
  //has delay so cannot be called directly by a function
  task wait_on_err_count();
    forever begin
      @(err_cnt);
      if(err_cnt == 3) begin
        $display("Error Thershold Reached!!! Hence, Terminating the simulation!");
        $finish;
      end
    end
  endtask
  
endclass
