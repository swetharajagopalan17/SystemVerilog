// New_packet

class new_packet extends packet;
  
  constraint valid{
    inp inside {[11:20]};
  }
  
endclass
