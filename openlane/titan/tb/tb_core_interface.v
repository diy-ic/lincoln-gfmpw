module tb_core_interface(
    input wire clk_i,
    input wire [7:0] instruction_i,
    input wire [23:0] address_i,
    input wire [31:0] value_i,
    output wire [31:0] result_o,
    output wire [31:0] stream_o
);

    `ifdef COCOTB_SIM
        initial begin
            $dumpfile("waves_tb_core_interface.vcd");
            $dumpvars(0, uut_ci);
        end
    `endif

    core_interface # (
        .TOTAL_INPUTS(4), .TOTAL_OUTPUTS(1), .START_ADDRESS(0), .END_ADDRESS(4)
    ) uut_ci (
        .clk_i(clk_i), .instruction_i(instruction_i), .address_i(address_i), 
        .value_i(value_i), .result_o(result_o), .stream_o(stream_o)
    );

endmodule