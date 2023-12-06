module lincoln_gfmpw (
`ifdef USE_POWER_PINS
    inout vdd,	// User area 1 1.8V supply
    inout vss,	// User area 1 digital ground
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
    input  [15:0] io_in,
    output [15:0] io_out,
    output [15:0] io_oeb,

    // IRQ
    output [2:0] irq
);

    // shut up about no driver on signals
    assign wbs_ack_o = 'h0;
    assign wbs_dat_o = 'h0;
    assign la_data_out  = 'h0;
    assign io_out[15:1] = 'h0;
    assign irq = 'h0;

    assign io_oeb = 32'hFFFE;

    wire [31:0] w_baby_ram_data_i, w_baby_ram_data_o, w_baby_ram_addr;
    wire w_baby_ram_we, w_baby_ram_clk;

    manchester_baby manchester_baby (
        `ifdef USER_POWER_PINS
            .vdd(vdd), .vss(vss),
        `endif
        .clock(wb_clk_i), .reset_i(io_in[0]),
        .ram_data_i(w_baby_ram_data_o), .ram_data_o(w_baby_ram_data_i),
        .ram_addr_o(w_baby_ram_addr[4:0]), .ram_rw_en_o(w_baby_ram_we),
        .logisim_clock_tree_0_out(w_baby_ram_clk), .stop_lamp_o(io_out[0])
    );

    ram_5x32 ram_block (
        `ifdef USER_POWER_PINS
            .vdd(vdd), .vss(vss),
        `endif
        .clk_i(w_baby_ram_clk), .address_i(w_baby_ram_addr[4:0]),
        .data_i(w_baby_ram_data_i), .data_o(w_baby_ram_data_o)
    );


endmodule