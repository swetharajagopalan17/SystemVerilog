// Code your testbench here
// or browse Examples
module test;
 
  reg a; // Data type is reg Variable name is a
  		 // 0 1 x z
  
  bit b;
  byte c;
  
 typedef bit [3:0] nibble;
  
  nibble a1;
  
typedef  enum {IDLE,WAIT,LOAD,DONE} enum_t;
typedef  enum {RED,BLUE,GREEN} enum_c;
  
  function enum_t get(input enum_t arg);
    case(arg)
      IDLE: return WAIT;
      WAIT: return LOAD;
      LOAD: return DONE;
      default: return arg;
    endcase
  endfunction
  
  enum_t v1;
  
  initial begin
 	v1 = WAIT;
    v1 = get(v1);
    $display("After Function call v1=%0s",v1.name());
    
    a1 = 4'd3;
    $display("a1=%b",a1);
  end
endmodule
