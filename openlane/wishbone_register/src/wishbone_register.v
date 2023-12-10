module wishbone_register # (
    // addresses must be after 30 00 00 00 
    // https://caravel-harness.readthedocs.io/en/latest/memory-mapped-io-summary.html
    parameter ADDRESS = 32'h30000000
) (
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    // input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    input [31:0] data_i,

    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,
    output reg [31:0] reg_q_o
);

    // reg [31:0] r_data_o;
    // assign reg_q_o = r_data_o;

    always @ (posedge wb_clk_i or posedge wb_rst_i) begin
        if (wb_rst_i) begin
            // r_data_o <= 'h0;
            wbs_ack_o <= 'h0;
        end else begin

            if (wbs_stb_i && wbs_adr_i == ADDRESS) begin
                wbs_ack_o <= 'h1;

                if (wbs_we_i == 1'b1) begin
                    reg_q_o <= wbs_dat_i;
                end else if (wbs_we_i == 1'b0) begin
                    wbs_dat_o <= data_i;
                end 
            end
        end
    end
endmodule

module wishbone_reg_mut_addr (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    // addresses must be after 30 00 00 00 
    // https://caravel-harness.readthedocs.io/en/latest/memory-mapped-io-summary.html
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    // input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    input [31:0] data_i,
    input [31:0] address,

    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,
    output reg [31:0] reg_q_o
);

    always @ (posedge wb_clk_i or posedge wb_rst_i) begin
        if (wb_rst_i) begin
            wbs_ack_o <= 'h0;
        end else begin

            if (wbs_stb_i && wbs_adr_i == address) begin
                wbs_ack_o <= 'h1;

                if (wbs_we_i == 1'b1) begin
                    reg_q_o <= wbs_dat_i;
                end else if (wbs_we_i == 1'b0) begin
                    wbs_dat_o <= data_i;
                end 
            end
        end
    end
endmodule