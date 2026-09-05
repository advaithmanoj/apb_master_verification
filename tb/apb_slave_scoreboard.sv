//for apb protocol apb_enable must be asserted a cycle later then apb_sel
//best done with assertions, not inculded in this testbench
class apb_slave_scoreboard;
  mailbox #(apb_slave_transaction) mon2sb;
  apb_slave_transaction tr;
  bit[4:0] count;
  
  function new (mailbox #(apb_slave_transaction) mon2sb);
    $display("[INFO] @ %0t: Creating the apb_slave_scoreboard", $time);
  this.mon2sb = mon2sb;
    count = 0;
  endfunction

  // Compare the expected and actual values of the write transaction
  function void compare_write_transaction ();
    bit [15:0] exp_paddr;
    bit        exp_pwrite;
    // expected values
    exp_pwrite = 1'b1;
    exp_paddr = 16'(count);
    // Comparing the expected and actual values
    if (exp_pwrite !== tr.apb_pwrite) begin
      $fatal(1, $sformatf("Expected apb_pwrite doesn't match with the actual output. Expected apb_pwrite: 0x%h, Got apb_pwrite: 0x%h", exp_pwrite, tr.apb_pwrite));
    end else if (exp_paddr !== tr.apb_paddr) begin
      $fatal(1, $sformatf("Expected apb_paddr doesn't match with the actual output. Expected apb_paddr: 0x%h, Got apb_paddr: 0x%h", exp_paddr, tr.apb_paddr));
    end
  endfunction

  function void compare_read_transaction ();
    bit [15:0] exp_paddr;
    bit        exp_pwrite;

    //expected values
    exp_pwrite = 1'b0;
    exp_paddr = 16'(count%16);
    
    // Compare the expected and actual values
    if (exp_pwrite !== tr.apb_pwrite) begin
      $fatal(1, $sformatf("Expected apb_pwrite doesn't match with the actual output. Expected apb_pwrite: 0x%h, Got apb_pwrite: 0x%h", exp_pwrite, tr.apb_pwrite));
    end else if (exp_paddr !== tr.apb_paddr) begin
      $fatal(1, $sformatf("Expected apb_paddr doesn't match with the actual output. Expected apb_paddr: 0x%h, Got apb_paddr: 0x%h", exp_paddr, tr.apb_paddr));
    end
  endfunction


  virtual task run ( );
    forever begin
      // Wait for the transaction from the monitor
      // Call the appropriate compare function based on the count
      mon2sb.get(tr);
      if (count <= 15) begin
        compare_write_transaction(); end
      else begin
        compare_read_transaction(); 
      end
      count = count + 1;
    end
  endtask

endclass
