class apb_slave_environment;
  apb_slave_agent a;
  apb_slave_scoreboard sb;
  mailbox #(apb_slave_transaction)  mon2sb;
  mailbox #(apb_slave_transaction) gen2drv;
  
  
  function new (virtual apb_interface vif, int num_tr);
    $display ("[INFO] %0t: Creating the apb_slave_environment", $time);
 
    mon2sb  = new();
    gen2drv = new();
    a  = new (gen2drv,mon2sb,vif,num_tr);
    sb = new(mon2sb);
  endfunction

  virtual task run ();
    $display ("[INFO] %0t: Running apb_slave_environment", $time);
    a.run();
    sb.run();
  endtask

endclass
