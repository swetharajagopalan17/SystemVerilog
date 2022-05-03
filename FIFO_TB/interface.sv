//filename:- interface.sv
interface FIFO_intf(input logic clk, rst);
  logic [3:0] data_in, data_out;
  logic wr_en;
  logic rd_en;
  logic full; 
  logic empty;
  
  //If Required we have clocking block

  modport mod_port(input wr_en, rd_en, data_in, clk, rst, output data_out, full, empty);

endinterface
