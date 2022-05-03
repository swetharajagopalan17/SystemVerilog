//filename:- FIFO_gen.sv

//Random Write and Read
class FIFO_gen;
  trans tx;
  virtual FIFO_intf vif;
  
  virtual task run(virtual  FIFO_intf vif);
    this.vif = vif;
    tx = new();
    repeat(20) begin 
          @(posedge vif.clk);
           wait(vif.rst) begin
             assert(tx.randomize());
             if(tx.wr_en)
               $display("\n*********************WRITE OPERATION STARTS********************");
             else
               $display("\n*********************READ OPERATION STARTS*******************");
           $display("Inside GENERATOR: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, $time);
          cfg::m_box.put(tx);
          
        end
    end 
     endtask
  
endclass 



//////Write Only/////
class FIFO_write_gen extends FIFO_gen;
  trans tx;
  virtual FIFO_intf vif;
  
  virtual task run(virtual  FIFO_intf vif);
    this.vif = vif;
      tx = new();
    repeat(20) begin 
          @(posedge vif.clk);
           wait(vif.rst) begin
             tx.randomize() with {wr_en == 1;};
             if(tx.wr_en)
               $display("\n*********************WRITE OPERATION STARTS********************");
             else
               $display("\n*********************READ OPERATION STARTS*******************");
           $display("Inside GENERATOR: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, $time);
          cfg::m_box.put(tx);
          
        end
      end 
     endtask
  
endclass


//////Write Read sequencial/////
class FIFO_wr_rd_sequential_gen extends FIFO_gen;
  trans tx;
  virtual FIFO_intf vif;
  
  virtual task run(virtual  FIFO_intf vif);
    this.vif = vif;
      tx = new();
    repeat(20) begin 
          @(posedge vif.clk);
           wait(vif.rst) begin
             tx.randomize() with {wr_en == 1;};
             if(tx.wr_en)
               $display("\n*********************WRITE OPERATION STARTS********************");
             else
               $display("\n*********************READ OPERATION STARTS*******************");
               $display("Inside GENERATOR: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, $time);
               cfg::m_box.put(tx);
             
            @(posedge vif.clk);
             tx.randomize() with {wr_en == 0;};
             if(tx.wr_en)
               $display("\n*********************WRITE OPERATION STARTS********************");
             else
               $display("\n*********************READ OPERATION STARTS*******************");
               $display("Inside GENERATOR: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, $time);
               cfg::m_box.put(tx);
          
        end
    end 
     endtask
  
endclass


//WR sequential 5 each
class FIFO_wr_rd_sequential_gen_2 extends FIFO_gen;
  trans tx;
  virtual FIFO_intf vif;
  
  virtual task run(virtual FIFO_intf vif);
    $display("Inside new sequence");
    this.vif = vif;
      tx = new();
    
    repeat(5) begin 
          @(posedge vif.clk);
           wait(vif.rst) begin
             tx.randomize() with {wr_en == 1;};
             if(tx.wr_en)
               $display("\n*********************WRITE OPERATION STARTS********************");
             else
               $display("\n*********************READ OPERATION STARTS*******************");
               $display("Inside GENERATOR: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, $time);
               cfg::m_box.put(tx);
           end
    end
    
    repeat(5) begin 
          @(posedge vif.clk);
           wait(vif.rst) begin
             tx.randomize() with {wr_en == 0;};
             if(tx.wr_en)
               $display("\n*********************WRITE OPERATION STARTS********************");
             else
               $display("\n*********************READ OPERATION STARTS*******************");
               $display("Inside GENERATOR: wr_en:%0d rd_en:%0d data_in:%0d data_out:%0d", tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, $time);
               cfg::m_box.put(tx);
           end
    end
  endtask
endclass
  

