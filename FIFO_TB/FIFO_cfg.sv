//filename:- FIFO_cfg.sv
class cfg;
  //static virtual FIFO_intf vif;
  static mailbox m_box = new();
  static mailbox mon2sb = new();
endclass
