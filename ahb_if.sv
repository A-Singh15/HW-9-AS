interface ahb_if (
    input logic HCLK
);
    logic [20:0] HADDR;
    logic        HWRITE;
    logic [1:0]  HTRANS;
    logic [7:0]  HWDATA;
    logic [7:0]  HRDATA;
    logic        HRESET;

    // Clocking block for AHB signals
    clocking ahb_cb @(posedge HCLK);
        output HADDR;
        output HWRITE;
        output HTRANS;
        output HWDATA;
        input  HRDATA;
        output HRESET;
    endclocking

endinterface
