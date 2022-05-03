//filename:- FIFO_env.sv
class FIFO_env;
  FIFO_gen gen = new();
  FIFO_write_gen wr_gen= new();
  FIFO_wr_rd_sequential_gen wr_rd_sequential_gen= new();
  FIFO_wr_rd_sequential_gen_2 wr_rd_sequential_gen_2 = new();
  FIFO_bfm bfm = new();
  FIFO_mon mon = new();
  FIFO_sb sb = new();
  task run(virtual FIFO_intf vif);
     fork 
       gen.run(vif);
       bfm.run(vif);
       mon.run(vif);
       sb.run(vif);
     join
  endtask
endclass
