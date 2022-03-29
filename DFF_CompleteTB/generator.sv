// Generator Class

class generator;
  
  packet pkt,ref_pkt;
  mailbox #(packet) mbx;
  bit [7:0] pkt_count;
  
  function new(input mailbox #(packet) mbx_inp, input bit [7:0] count);
    mbx = mbx_inp;
    pkt_count = count;
     ref_pkt = new;
  endfunction
  
  task run();
    repeat(pkt_count) begin
      pkt=new;
      void'(ref_pkt.randomize());
      pkt.copy(ref_pkt);
      $display("[Gen] pkt.inp=%0d at time=%0t",pkt.inp,$time);
      mbx.put(pkt);
    end
  endtask
  
endclass
