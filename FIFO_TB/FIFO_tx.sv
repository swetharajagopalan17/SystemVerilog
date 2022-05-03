//filename:- FIFO_tx.sv
class trans;
  randc bit[3:0] data_in;
  rand bit wr_en;
  rand bit rd_en;
  bit[3:0] data_out;
  bit full, empty;
  
  //Constraint for write and read
  constraint wr_rd_en_c{wr_en != rd_en;}
  
  //Weighted distribution 
  constraint wr_c{wr_en dist{0:= 50, 1:= 50};}
  
  //Constraint for write only and to achieve FULL condition
 //  constraint wr_en_c{wr_en == 1;}
    
endclass  
