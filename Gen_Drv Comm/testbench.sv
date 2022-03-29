// Code your testbench here
// or browse Examples
`include "packet.sv"
module top;
 packet ref_pkt,pkt,recv_pkt; 
  mailbox #(packet) mbx;
  
  initial begin
    ref_pkt=new;
    mbx = new(4);
    
    fork
    	begin: Generator
          repeat(4) begin
            pkt=new;
            void'(ref_pkt.randomize());
            pkt.copy(ref_pkt);
          	$display("[Gen] pkt.inp=%0d",pkt.inp);
          	mbx.put(pkt);
          end
        end
      	begin: Driver
           repeat(4) begin
          	mbx.get(recv_pkt);
          	$display("[Drv] pkt.inp=%0d",recv_pkt.inp);
           end
        end
    join
    
  end
  
endmodule
