//filename:- design.sv
module FIFO #( parameter width = 2,
              parameter depth = 4)(clk,rst,r_en,w_en,data_in,data_out,full,empty);
       

        input clk,rst,r_en,w_en;
        input [width - 1:0]data_in;
        output full,empty;
        output reg [width - 1:0]data_out;
        reg [width:0]front,rear;
        reg [width+1:0] index;
        reg [width - 1:0] fifo[depth - 1:0];
  
  		assign full = (front == {~rear[width],rear[width-1:0]})?1:0;
  		assign empty = (front == rear)?1:0;

       always@(posedge clk or negedge rst)
        	begin
              if(!rst)
                  begin
                    data_out <= 4'b0000;
                    front <= 0;
                    rear <= 0;
                    for(index = 0;index < depth;index = index + 1)
                      fifo[index] <= 4'b0000;
                  end

                else
                  begin 
                    if(w_en && !full)
                      begin
                        fifo[rear[width-1:0]] <= data_in;
                        rear <= rear + 1; 
                      end

                     else if(r_en && !empty)
                      begin
                        data_out <= fifo[front[width-1:0]];
                        front <= front +1;
                      end
                  end
            end
endmodule

                                           
 
