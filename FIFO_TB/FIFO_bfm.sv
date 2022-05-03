//filename:- FIFO_bfm.sv
class FIFO_bfm;
  trans tx;
  virtual FIFO_intf vif;
  
  task run(virtual FIFO_intf vif);
  this.vif = vif;                           
    tx = new();
    repeat(20)
      begin
      @(posedge vif.clk);
        cfg::m_box.get(tx); 
        if(tx.wr_en)
         begin
          vif.data_in <= tx.data_in;
          vif.wr_en <= tx.wr_en; 
          vif.rd_en <= tx.rd_en;
           $monitor("Inside BFM WRITE: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, $time);
       end
      
      if(tx.rd_en)
        begin
          vif.wr_en <= tx.wr_en;
          vif.rd_en <= tx.rd_en;
          //response signal receive from DUT
          tx.data_out = vif.data_out;
          tx.full = vif.full;
          tx.empty = vif.empty;
          $monitor("Inside BFM READ: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d %0t", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, $time);
         end
      end
    
   endtask
  
endclass
