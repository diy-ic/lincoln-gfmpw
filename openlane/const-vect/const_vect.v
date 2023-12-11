module constant_vectors(
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    // output [7:0] zeroes,
    // output [7:0] ones
    output zero,
    output [37:0] io_oeb_val
);
    assign zero = 1'b0;
    assign io_oeb_val = 37'h7BFFFFF7F;
    // assign zeroes = 8'h00;
    // assign ones = 8'hFF;

endmodule