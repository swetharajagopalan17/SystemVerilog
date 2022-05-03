//filename:- FIFO_mon.sv
class FIFO_mon;
  trans tx;
  virtual FIFO_intf vif;
  
  task run(virtual  FIFO_intf vif);
    this.vif = vif;
     tx = new();
      forever begin
        @(negedge vif.clk);
           if(vif.rst) 
            begin
            tx.wr_en = vif.wr_en;
            tx.data_in = vif.data_in;
            tx.full = vif.full;
            tx.empty = vif.empty;
            tx.rd_en = vif.rd_en;
            tx.data_out = vif.data_out;
            cfg::mon2sb.put(tx);
            $display("Inside MONITOR: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d full:%0d empty:%0d", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, tx.full, tx.empty, $time);
           
         end
      end
  endtask
  
endclass
