//filename:- FIFO_sb.sv
class FIFO_sb;
  trans tx;
  virtual FIFO_intf vif;
  int input_data_queue[$];
  int output_data_queue[$];
  bit [31:0] input_data, output_data;
  
  task run(virtual FIFO_intf vif);
    this.vif = vif; 
    forever begin
      cfg::mon2sb.get(tx);
      fork
        collect_write_data(tx);
        collect_read_data(tx);
        compare_data();
      join_none 
    end
  endtask
   
  
  task collect_write_data(trans tx);
    begin
      if(tx.full == 1)
        $display("The FIFO is FULL",$time);    
        
      if(tx.wr_en)
        begin
          $display("**********************WRITE OPERATION ENDS*************************", $time);
          input_data_queue.push_back(tx.data_in);
        end
    end
  endtask
  
  task collect_read_data(trans tx);
    begin
      if(tx.empty == 1)
        $display("The FIFO is EMPTY",$time);
      
      if(tx.rd_en )
         begin
           @(negedge vif.clk)
           #1;
           output_data_queue.push_back(tx.data_out);
           $display("Inside sb pushing read_data %0d", tx.data_out, $time);
         end
    end
  endtask
      
  
  task compare_data();
    begin
      wait(output_data_queue.size>0);
       output_data = output_data_queue.pop_front;
      
      wait(input_data_queue.size>0);
       input_data = input_data_queue.pop_front;  
      
      if(input_data == output_data)
           $display("Inside SCOREBOARD: Data_in : %0d and Data_out : %0d inside FIFO are matched",input_data,output_data,$time);
           else
           $display("Inside SCOREBOARD: Data_in : %0d and Data_out : %0d inside FIFO are mismatched",input_data,output_data,$time);
        $display("********************READ OPERATION ENDS**********************", $time);
    end
  endtask
    
endclass
