// Code your testbench here
// or browse Examples
module top;
  
//  A a1,a2,a3;
  
  initial begin
   // a1=A::get();
  //  a2=A::get();
	
  //  a1.error_msg("Packet 1 not matched");
    #1;
  //  a2.error_msg("Packet 2 not matched");
    #1;
    A::obj.error_msg("Packet 3 not matched");
    #1;
    A::obj.error_msg("Packet 4 not matched");
    #1;
    A::obj.error_msg("Packet 5 not matched");
    #1;
    A::obj.error_msg("Packet 6 not matched");
  end
  
endmodule
