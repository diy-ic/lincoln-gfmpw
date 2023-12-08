// example only
module titan (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
	input wire sys_clock_i,
	input wire spi_clock_i,
	input wire spi_cs_i,     // chip select
	input wire spi_pico_i,   // peripheral in, controller out - rx from mcu
	output wire spi_poci_o   // peripheral out, controller in - tx to mcu
	// input wire wb_clk_i,
	// input wire [2:0] io_in,
	// output wire io_out
);

	logic [7:0] rx_byte_i, tx_byte_o;
	// wire rx_valid_w, sys_clock_i, spi_cs_i, spi_pico_i, spi_poci_o;

	// assign sys_clock_i = wb_clk_i;
	// assign spi_cs_i = io_in[0];
	// assign spi_clock_i = io_in[1];
	// assign spi_pico_i = io_in[2];
	// assign spi_poci_o = io_out[0];

	// assign io_out[38:1] = 'h0;


	spi_byte_if spi_interface_cvonk (
		.sysClk(sys_clock_i), .SCLK(spi_clock_i),
		.MOSI(spi_pico_i), .MISO(spi_poci_o), .SS(spi_cs_i),
		.tx(tx_byte_o), .rx(rx_byte_i), .rxValid(rx_valid_w)
	);

	// internal buses used to interface with the cores
	logic [7:0] internal_bus_instruction;
	logic [23:0] internal_bus_address;
	logic [31:0] internal_bus_value, internal_bus_result;
	wire [31:0] internal_bus_stream_w;

	instruction_handler internal_ih (
		.clk_i(sys_clock_i), .spi_rx_valid_i(rx_valid_w), .spi_rx_byte_i(rx_byte_i),
		.result_i(internal_bus_result), .stream_i(internal_bus_stream_w),
		.instruction_o(internal_bus_instruction), .address_o(internal_bus_address),
		.value_o(internal_bus_value), .spi_tx_byte_o(tx_byte_o)
	);

	core_interface # (
		.TOTAL_INPUTS(2), .TOTAL_OUTPUTS(1), .START_ADDRESS(0), .END_ADDRESS(4)
	)  ci_neuron (
		.clk_i(sys_clock_i), .instruction_i(internal_bus_instruction), .address_i(internal_bus_address),
		.value_i(internal_bus_value), .result_o(internal_bus_result), .stream_o(internal_bus_stream_w)
	);

endmodule