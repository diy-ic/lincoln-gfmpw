module tb_decoder (
    input [7:0] instruction_i,
    output [65:0] decoded_instruction_o
);

    `ifdef COCOTB_SIM
        initial begin
            $dumpfile("waves_tb_decoder.vcd");
            $dumpvars(0, uut_decoder);
        end
    `endif

    mos6502_decoder uut_decoder (
        .instruction_i(instruction_i), .decoded_instruction_o(decoded_instruction_o)
    );

endmodule