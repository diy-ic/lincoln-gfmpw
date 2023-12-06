module ram # (
    parameter ADDRESS_WIDTH = 5,
    parameter DATA_WIDTH = 32,
    parameter MEMORY_DEPTH = 32
) (
    input clk_i,
    input [ADDRESS_WIDTH-1:0] address_i,
    input [DATA_WIDTH-1:0] data_i,
    input we_i, // write enable
    output [DATA_WIDTH-1:0] data_o
);

    reg [DATA_WIDTH-1:0] memory [0:MEMORY_DEPTH-1];
    reg [DATA_WIDTH-1:0] r_data_o;

    assign data_o = r_data_o;

    always @ (posedge clk_i) begin

        // read
        if (we_i == 1'b0) begin
            r_data_o <= memory[address_i];

        // write
        end else if (we_i == 1'b1) begin
            memory[address_i] <= data_i;
        end
    end
endmodule