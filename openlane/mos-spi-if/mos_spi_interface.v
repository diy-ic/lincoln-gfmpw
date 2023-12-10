module mos_spi_interface (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    input wire sys_clock_i,
	input wire rst_i,
	input wire spi_clock_i,
	input wire spi_cs_i,     // chip select
	input wire spi_pico_i,   // peripheral in, controller out - rx from mcu
	output wire spi_poci_o   // peripheral out, controller in - tx to mcu
);

wire [7:0] rx_byte_i, tx_byte_o;
wire rx_valid_w;

spi_byte_if spi_interface_cvonk (
    .sysClk(sys_clock_i), .SCLK(spi_clock_i),
    .MOSI(spi_pico_i), .MISO(spi_poci_o), .SS(spi_cs_i),
    .tx(tx_byte_o), .rx(rx_byte_i), .rxValid(rx_valid_w)
);

// internal buses used to interface with the cores
wire [7:0] internal_bus_instruction;
wire [23:0] internal_bus_address;
wire [31:0] internal_bus_value;
reg [31:0] internal_bus_result;

instruction_handler internal_ih (
    .clk_i(sys_clock_i), .spi_rx_valid_i(rx_valid_w), .spi_rx_byte_i(rx_byte_i),
    .result_i(internal_bus_result), .stream_i('h0),
    .instruction_o(internal_bus_instruction), .address_o(internal_bus_address),
    .value_o(internal_bus_value), .spi_tx_byte_o(tx_byte_o), .rst_i(rst_i)
);

// 24 bit address
// 00 00 00 : instruction
// 00 00 01 : 31:0 bits of decoder
// 00 00 02 : 63:32 bits of decoder
// 00 00 03 : 65:64 bits of decoder, zero-extended to match 32 bits

localparam INSTRUCTION_WRITE = 8'h01;
localparam INSTRUCTION_READ = 8'h02;

localparam INSTRUCTION_ADDRESS = 24'h0;
localparam LOW_REG_ADDR = 24'h000001;
localparam MID_REG_ADDR = 24'h000002;
localparam HI_REG_ADDR  = 24'h000003;

reg [7:0] r_decoder_instruction;
wire [65:0] w_decoder_out;

always @ (*) begin

    if (internal_bus_instruction == INSTRUCTION_WRITE) begin
        // can only write to instruction reg of decoder
        r_decoder_instruction <= internal_bus_value[7:0];
    
    end else if (internal_bus_instruction == INSTRUCTION_READ) begin
        
        case (internal_bus_address)

            INSTRUCTION_ADDRESS: internal_bus_result <= {{24{1'b0}}, r_decoder_instruction};
            LOW_REG_ADDR: internal_bus_result <= w_decoder_out[31:0];
            MID_REG_ADDR: internal_bus_result <= w_decoder_out[63:32]; 
            HI_REG_ADDR: internal_bus_result <= {{30{1'b0}}, w_decoder_out[65:64]};

        endcase
    end
end

mos6502_decoder decoder (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    .instruction_i(r_decoder_instruction),
    .decoded_instruction_o(w_decoder_out)
);

endmodule