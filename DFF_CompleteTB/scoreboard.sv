// Scoreboard class

class scoreboard;
  
  mailbox #(packet) iMon_mbx; // Transaction form input monitor
  mailbox #(packet) oMon_mbx; // Transaction form output monitor
  
  packet exp_pkt; // Golden model, reference, expected
  packet recv_pkt; // Actual, response from the DUT
  
  bit [15:0] matched, mis_matched;
  bit [15:0] pkt_count;
  
  function new(input mailbox #(packet) inp_mbx, input mailbox #(packet) outp_mbx);
    $display("[Scb] Called New constructor");
    iMon_mbx = inp_mbx;
    oMon_mbx = outp_mbx;
  endfunction
  
  task run();
    forever begin
    //  $display("[scb] Start of forever block");
      iMon_mbx.get(exp_pkt); // Receive expected outp
   //   $display("[scb] forever block after iMon.get()");
      oMon_mbx.get(recv_pkt); // Receive actual outp
    //  $display("[scb] forever block after oMon.get()");
      
      pkt_count++;
      
      if(exp_pkt.inp == recv_pkt.inp) begin
        matched++;
        $display("[Info] Transaction %0d Matched exp=%0d recv=%0d at time=%0t",pkt_count,exp_pkt.inp,recv_pkt.inp,$time);
      end
      else begin
         mis_matched++;
        $display("[Error] Transaction %0d Mis_Matched exp=%0d recv=%0d at time=%0t",pkt_count,exp_pkt.inp,recv_pkt.inp,$time);
      end
    end
  endtask
  
endclass
