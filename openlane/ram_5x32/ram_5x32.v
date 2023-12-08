module ram_5x32 (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    input clk_i,
    input we_i, // write enable
    input [4:0] address_i,
    input [31:0] data_i,
    output [31:0] data_o
);


    ram_parametric # (
        .ADDRESS_WIDTH(5), .DATA_WIDTH(32), .MEMORY_DEPTH(32)
    ) ram_5x32_instance (
    
    // `ifdef USE_POWER_PINS
	//     .vdd(vdd),	// User area 1 1.8V power
	//     .vss(vss),	// User area 1 digital ground
    // `endif
        .clk_i(clk_i), .we_i(we_i), .address_i(address_i), 
        .data_i(data_i), .data_o(data_o)
    );


endmodule