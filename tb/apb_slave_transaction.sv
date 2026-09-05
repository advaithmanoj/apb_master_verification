//trxn class contains pins to DUT,constraints,pre,post randomize defintions or any methods to be used throught out the testbench
class apb_slave_transaction;
 
  rand bit apb_pready;
  rand bit [31:0] apb_prdata; //rand key word to randomize them when .randomize is called

  //o/p signals from dut
  logic [15:0]      apb_paddr;
  logic             apb_pwrite;
  logic [31:0]      apb_pwdata; 
 
  virtual function void display(string prefix="");   =
    $display("INFO at %0t: %s apb_pready %h apb_prdata %h",$time,prefix,apb_pready,apb_prdata);  
  endfunction

  //copy func with return type as the transaction class
  virtual function apb_slave_transaction copy (); //by default a var copy will be made of type apb_slave_transaction
    copy = new(); //allocating mem 
    copy.apb_pready = this.apb_pready; //copy 
    copy.apb_prdata = this.apb_prdata;
    copy.apb_paddr = this.apb_paddr; //copy 
    copy.apb_pwrite = this.apb_pwrite;
    copy.apb_pwdata = this.apb_pwdata;
    return copy;
  endfunction

endclass
