// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [63:0] la_data_in,
    output [63:0] la_data_out,
    input  [63:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

wire w_shared_spi_clk, w_shared_spi_pico, w_shared_spi_poci;
assign w_shared_spi_clk = io_in[4];
assign w_shared_spi_pico = io_in[5];
assign w_shared_spi_poci = io_out[6];

wire w_zero;
constant_vectors consts (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    .zero(w_zero)
);

titan titan_instance (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    .sys_clock_i(wb_clk_i),
    .rst_i(wb_rst_i),
    .spi_clock_i(w_shared_spi_clk),
    .spi_cs_i(io_in[7]),
    .spi_pico_i(w_shared_spi_pico),  // input
    .spi_poci_o(w_shared_spi_poci)   // output
);


// ------ MOS 6502 DECODER + SUPPORTING LOGIC ------
wire [65:0] w_decoded_instruction;
wire [31:0] w_decoded_muxed;
assign la_data_out[31:0] = w_decoded_muxed;
// wire [7:0] w_instruction; // unused

mos6502_decoder mos_decoder (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    .instruction_i(la_data_in[7:0]),
    .decoded_instruction_o(w_decoded_instruction)
);

mos_la_interface mos_la_mux (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    .decoder_result_i(w_decoded_instruction),
    .sel(io_in[1:0]),
    .decoder_bytes_o(w_decoded_muxed)
);

// ------ MANCHESTER BABY + SUPPORTING HARDWARE ------
wire [4:0] w_baby_ram_addr, w_spi_ram_addr;
wire [31:0] w_ram_data_from_baby, w_ram_data_to_baby, w_spi_ram_data_from_if, w_spi_ram_data_to_if;
wire w_baby_ram_we; // write enable
wire w_baby_ram_clk; // logisim clock

wire w_ram_plex_clk;
wire w_ram_plex_we;
wire [31:0] w_ram_plex_data_from_plex, w_ram_plex_data_to_plex;
wire [4:0] w_ram_plex_addr;
wire w_baby_halt_status;

manchester_baby manchester_baby_instance (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    .sys_clk_i(wb_clk_i),
    .rst_i(wb_rst_i),
    .hlt_ext_i(io_in[2]),
    .hlt_int_i(w_zero),
    .hlt_status(w_baby_halt_status),
    .ram_data_i(w_ram_data_to_baby),
    .ram_data_o(w_ram_data_from_baby),
    .ram_addr_o(w_baby_ram_addr),
    .ram_rw_en_o(w_baby_ram_we),
    .stop_lamp_o(io_out[3]),
    .logisim_clock_tree_0_out(w_baby_ram_clk)
);

ram_5x32 ram_block (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    // .clk_i(w_baby_ram_clk),
    // .we_i(w_baby_ram_we),
    // .address_i(w_baby_ram_addr),
    // .data_i(w_ram_data_from_baby),
    // .data_o(w_ram_data_to_baby)
    .clk_i(w_ram_plex_clk),
    .we_i(w_baby_ram_we),
    .address_i(w_ram_plex_addr),
    .data_i(w_ram_plex_data_from_plex),
    .data_o(w_ram_plex_data_to_plex)
);

spi_ram_interface spi_ram_interface (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    .sys_clock_i(wb_clk_i),
    .rst_i(wb_rst_i),
  
    .spi_clock_i(w_shared_spi_clk),
    .spi_cs_i(io_in[8]),
    .spi_pico_i(w_shared_spi_pico),
    .spi_poci_o(w_shared_spi_poci),
  
    // .we_o(), // TODO: re-connect this signal
    .addr_o(w_spi_ram_addr),
    .data_o(w_spi_ram_data_from_if),
    .data_i(w_spi_ram_data_to_if)
);

ram_plexer ram_plex (
`ifdef USE_POWER_PINS
    .vdd(vdd),
    .vss(vss),
`endif
    .baby_clk_i(w_baby_ram_clk),
    .baby_addr_i(w_baby_ram_addr),
    .baby_data_i(w_ram_data_from_baby),
    .baby_data_o(w_ram_data_to_baby),
    
    .spi_clk_i(wb_clk_i),
    .spi_addr_i(w_spi_ram_addr),
    .spi_data_i(w_spi_ram_data_from_if),
    .spi_data_o(w_spi_ram_data_to_if),
    
    .ram_clk_o(w_ram_plex_clk),
    .ram_addr_o(w_ram_plex_addr),
    .ram_data_o(w_ram_plex_data_from_plex),
    .ram_data_i(w_ram_plex_data_to_plex),

    .baby_halt(w_baby_halt_status),
    .spi_cs(io_in[8])
);

endmodule	// user_project_wrapper
`default_nettype wire