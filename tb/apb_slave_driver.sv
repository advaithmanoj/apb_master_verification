class apb_slave_driver;
  mailbox #(apb_slave_transaction)  gen2drv;
  virtual apb_interface             vif;
  int                               num_tr; 

  function new (mailbox #(apb_slave_transaction) gen2drv, virtual apb_interface vif, int num_tr);
    $display("[INFO] @ %0t: Creating the apb_slave_driver", $time);
    this.gen2drv = gen2drv;
    this.vif = vif;
    this.num_tr = num_tr;
  endfunction

  virtual task reset_seq ();  
    vif.cb.reset_n <= 1'b0;
    repeat (3) @vif.cb;
    vif.cb.reset_n <= 1'b1;
    @vif.cb;
  endtask

  virtual task run ();
    apb_slave_transaction tr;
    forever begin
      if (num_tr == 0 )begin
        break;
      end
      // transaction from the mailbox
      gen2drv.get(tr);
      // Driving it onto interface
      vif.cb.apb_pready <= tr.apb_pready;
      @vif.cb;
      forever begin
        if (vif.cb.apb_psel & vif.cb.apb_penable & tr.apb_pready) begin
          // for evert valid apb_transfer, decerement count
          num_tr--;
          break;
        end else begin
          gen2drv.get(tr);
          vif.cb.apb_pready <= tr.apb_pready;
          vif.cb.apb_prdata <= tr.apb_prdata;
          @vif.cb;
          end
      end
    end
  endtask

endclass
