

class apb_slave_monitor;
  mailbox #(apb_slave_transaction) mon2sb; //1  creates a mailbox of type apb_slave_transaction named gen2drv
  apb_slave_transaction  tr;               //2  apb_slave_transaction gets a handle named blueprint
   virtual apb_interface  vif;


  function new (mailbox #(apb_slave_transaction) mon2sb, virtual apb_interface vif);
    $display("[INFO] @ %0t: Creating the apb_slave_monitor", $time);
    this.vif = vif;
    this.mon2sb = mon2sb;
    tr = new();
  endfunction


  virtual task run ();
    forever begin
      @vif.cb;
      if (vif.cb.apb_psel & vif.cb.apb_penable & vif.cb.apb_pready) begin
        tr.apb_paddr   = vif.cb.apb_paddr;
        tr.apb_pwrite  = vif.cb.apb_pwrite;
        tr.apb_pwdata  = vif.cb.apb_pwdata; 
        mon2sb.put(tr);
      end
    end
  endtask

endclass
