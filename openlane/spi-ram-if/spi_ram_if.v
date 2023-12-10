// READ & WRITE instructions correspond to the R/W signal for RAM
// address is pruned to 5 bits only
module spi_ram_interface (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    input wire sys_clock_i,
	input wire rst_i,
	input wire spi_clock_i,
	input wire spi_cs_i,     // chip select
	input wire spi_pico_i,   // peripheral in, controller out - rx from mcu
	output wire spi_poci_o,   // peripheral out, controller in - tx to mcu

    output wire we_o,
    output wire [4:0] addr_o,
    output wire [31:0] data_o,
    input wire [31:0] data_i
);

	wire [7:0] rx_byte_i, tx_byte_o;
	wire rx_valid_w;

   	spi_byte_if spi_interface_cvonk (
		.sysClk(sys_clock_i), .SCLK(spi_clock_i),
		.MOSI(spi_pico_i), .MISO(spi_poci_o), .SS(spi_cs_i),
		.tx(tx_byte_o), .rx(rx_byte_i), .rxValid(rx_valid_w)
	); 

	wire [7:0] internal_bus_instruction;
	wire [23:0] internal_bus_address;

	instruction_handler internal_ih (
		.clk_i(sys_clock_i), .spi_rx_valid_i(rx_valid_w), .spi_rx_byte_i(rx_byte_i),
		.result_i(data_i), .stream_i('h0),
		.instruction_o(internal_bus_instruction), .address_o(internal_bus_address),
		.value_o(data_o), .spi_tx_byte_o(tx_byte_o), .rst_i(rst_i)
	);

    assign we_o = internal_bus_instruction[0];
    assign addr_o = internal_bus_address[4:0];


endmodule