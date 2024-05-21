interface sram_if (
    input logic HCLK
);
    logic [20:0] HADDR;
    logic        HWRITE;
    logic [7:0]  HWDATA;
    logic [7:0]  HRDATA;

    // Clocking block for SRAM signals
    clocking sram_cb @(posedge HCLK);
        output HADDR;
        output HWRITE;
        output HWDATA;
        input  HRDATA;
    endclocking

endinterface
