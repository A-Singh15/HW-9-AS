package ahb_pkg;

  // AHB Transaction Class
  class ahb_transaction;
    rand bit [20:0] HADDR;
    rand bit [1:0]  HTRANS;
    rand bit        HRESET;
    rand bit        HWRITE;
    rand bit [7:0]  HWDATA;
    rand bit [7:0]  HRDATA;

    constraint address_constraint {
      HADDR dist { [0:4] := 40, [27:31] := 40, [5:26] := 20 };
    }

    constraint htrans_constraint {
      HTRANS inside {2'b00, 2'b10};
    }

    constraint reset_constraint {
      HRESET dist {0 := 90, 1 := 10};
    }
    
    function new();
    endfunction
  endclass

endpackage
