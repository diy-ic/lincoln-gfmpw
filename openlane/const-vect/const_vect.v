module constant_vectors(
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    // output [7:0] zeroes,
    // output [7:0] ones
    output zero
);
    assign zero = 1'b0;
    // assign zeroes = 8'h00;
    // assign ones = 8'hFF;

endmodule