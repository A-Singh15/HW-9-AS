`timescale 1ns/1ps

module tb_top;
  import ahb_pkg::*;
  logic HCLK;
  logic [20:0] HADDR;
  logic HWRITE;
  logic [1:0] HTRANS;
  logic [7:0] HWDATA;
  logic [7:0] HRDATA;
  logic HRESET;

  // Instantiate AHB and SRAM interfaces
  ahb_if ahb_interface(HCLK);
  sram_if sram_interface(HCLK);

  // Device Under Test
  sram_control dut (
    .HCLK(HCLK),
    .ahb_bus(ahb_interface),
    .sram_bus(sram_interface)
  );

  // Clock generation
  initial begin
    HCLK = 0;
    forever #5 HCLK = ~HCLK;
  end

  // Stimulus program
  initial begin
    ahb_transaction txn;
    txn = new();

    // 10 back to back random writes
    repeat (10) begin
      txn.randomize();
      txn.HTRANS = 2'b10;
      txn.HRESET = 0;
      txn.HADDR = $urandom_range(0, 4);
      @(posedge HCLK);
      drive_ahb(txn);
    end

    // Display memory locations 0 to 4
    $display("Memory locations 0 to 4 after writes:");
    for (int i = 0; i < 5; i++) begin
      $display("Address %0d: Data = %0h", i, sram_interface.memory[i]);
    end

    // 10 back to back random reads
    repeat (10) begin
      txn.randomize();
      txn.HTRANS = 2'b10;
      txn.HRESET = 0;
      txn.HADDR = $urandom_range(0, 4);
      @(posedge HCLK);
      drive_ahb(txn);
    end

    // 10 random transactions
    repeat (10) begin
      txn.randomize();
      @(posedge HCLK);
      drive_ahb(txn);
    end

    $stop;
  end

  // Task to drive AHB signals
  task drive_ahb(ahb_transaction txn);
    @(posedge HCLK);
    ahb_interface.HADDR = txn.HADDR;
    ahb_interface.HWRITE = txn.HWRITE;
    ahb_interface.HTRANS = txn.HTRANS;
    ahb_interface.HWDATA = txn.HWDATA;
    ahb_interface.HRESET = txn.HRESET;
  endtask

  initial begin
    $dumpfile("waveform.vcd");  // VCD format
    $dumpvars(0, tb_top);
  end

endmodule
