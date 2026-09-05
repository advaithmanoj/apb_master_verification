`timescale 1ns/1ps
`include "apb_interface.sv"
import apb_slave_pkg::*;


module apb_slave_top ();
  logic                            clk;
  apb_slave_environment            env;
  int                              num_tr;

  apb_master APB (
    .clk              (clk),
    .reset_n          (apb_if.reset_n),

    .apb_psel_o       (apb_if.apb_psel),
    .apb_penable_o    (apb_if.apb_penable),
    .apb_paddr_o      (apb_if.apb_paddr),
    .apb_pwrite_o     (apb_if.apb_pwrite),
    .apb_pwdata_o     (apb_if.apb_pwdata),
    .apb_prdata_i     (apb_if.apb_prdata),
    .apb_pready_i     (apb_if.apb_pready)
  );

 
  apb_interface apb_if (.clk(clk));


  always begin
    clk = 1'b1;
    #5;
    clk = 1'b0;
    #5;
  end

  initial begin
    env = new(apb_if, 32);
    env.run();
    @(posedge clk);
    $finish();
  end

  initial begin
    $dumpfile(`QS_VCD_DUMP_NAME);
    $dumpvars(2, apb_slave_top);
  end

endmodule
