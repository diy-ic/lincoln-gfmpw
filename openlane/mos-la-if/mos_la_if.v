module mos_la_interface (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    input [65:0] decoder_result_i,
    input [1:0] sel,
    output reg [31:0] decoder_bytes_o
);

    always @(*) begin
        case (sel)
            2'b00: decoder_bytes_o <= decoder_result_i[31:0];
            2'b01: decoder_bytes_o <= decoder_result_i[63:32];
            2'b10: decoder_bytes_o <= {{30{1'b0}}, decoder_result_i[65:64]};
            default: decoder_bytes_o <= 'h0; 
        endcase
    end
endmodule