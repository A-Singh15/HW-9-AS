interface sram_if (
    input logic HCLK
);
    logic [20:0] A;
    logic        WE_b;
    logic        CE_b;
    logic        OE_b;
    logic [7:0]  DQ;

    // Clocking block for SRAM signals
    clocking sram_cb @(posedge HCLK);
        output A;
        output WE_b;
        output CE_b;
        output OE_b;
        inout  DQ;
    endclocking

endinterface
