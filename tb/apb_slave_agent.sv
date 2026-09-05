class apb_slave_agent;


  mailbox #(apb_slave_transaction)  gen2drv;
  mailbox #(apb_slave_transaction)  mon2sb;
  virtual apb_interface             vif;
  int num_tr;
  apb_slave_generator              gen;
  apb_slave_driver                 drv;
  apb_slave_monitor                mon;

  function new (mailbox #(apb_slave_transaction) gen2drv, mailbox #(apb_slave_transaction)  mon2sb, virtual apb_interface vif, int num_tr);
    $display("[INFO] @ %0t: Creating the apb_slave_agent", $time);
  
   this.gen2drv = gen2drv;
   this.mon2sb  = mon2sb ;
   this.vif = vif;
   this.num_tr = num_tr;
    gen = new(gen2drv);
    drv = new(gen2drv,vif,num_tr);
    mon = new(mon2sb,vif);
  endfunction

  virtual task run ();
    drv.reset_seq ();
    fork
      gen.run();
      drv.run();
      mon.run();
    join_any
    
  endtask

endclass
