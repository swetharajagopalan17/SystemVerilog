// Code your design here
module mux_4_1 ( input [1:0] sel , output y , input i0 , input i1 ,input i2 ,input i3 );
  
  assign y =  (!sel[1]) ?( !sel[0] ? i0 : i1 ) : ( !sel[0] ? i2 : i3 );
  
endmodule
