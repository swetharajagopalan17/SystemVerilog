// Code your design here
module seq_dect (input rst ,input clk , input in_d ,output reg dout);
  parameter s0 = 0 , s1 = 1 , s2 = 2 , s3 = 3 ;
  reg[1:0] cs,ns;
  
  always@(posedge clk) begin
    if(!rst) begin
      dout <= 0 ;
      cs <= s0; end
    else
      cs <= ns;
  end
  always@(*) begin
    case(cs) 
      s0 : if (in_d)
            begin 
             ns <= s1; 
             dout <= 0; 
            end
           else
             begin
               ns <= s0 ; 
               dout <= 0; 
              end
      s1 : if  (in_d) 
            begin 
              ns <= s1; 
              dout <= 0;
            end
           else
             begin
               ns <= s2 ; 
               dout <= 0; 
             end
      s2 : if (in_d)
             begin 
               ns <= s3 ;
               dout <= 0; 
             end
           else 
             begin 
               ns <= s0 ; 
               dout <= 0; 
             end
      s3 :  if (in_d) 
             begin 
               ns <= s0; 
               dout <= 1;
             end
           else 
             begin 
               ns <= s2 ; 
               dout <= 0; 
             end
    endcase
  end
endmodule
      
