

class apb_slave_generator;
  mailbox #(apb_slave_transaction) gen2drv; //1  creates a mailbox of type apb_slave_transaction named gen2drv
  apb_slave_transaction  blueprint;         //2  apb_slave_transaction gets a handle named blueprint
        
  
 
  function new (mailbox #(apb_slave_transaction) gen2drv); //new functionn with some inputs
    $display("[INFO] @ %0t: Creating the apb_slave_generator", $time);
    this.gen2drv = gen2drv;  //we copy the inputs to stuff of this class
    blueprint = new();  //object creation of apb_slave_transaction type
  endfunction

  virtual task run ();
    forever begin   //no of pkts created here
      if ( blueprint.randomize() == 0 ) //check randomzation failures
        $fatal(1,"SOMETHING IS WRONG AT %t :FAILED TO RANDOMIZE TO BLUPRINT OBJ",$time); //fatal error - simulation stops
      else
        void'(blueprint.randomize);
      gen2drv.put(blueprint.copy());//puts obj to mailbox,our txn has copy method which returns the obj which has the same content as the randomized
      blueprint.display("[GEN]"); //LOGGING to see if we have randomized
    end
  endtask

endclass















////3 step to follow
//   1.declaration  2.mapping  3.functionality
