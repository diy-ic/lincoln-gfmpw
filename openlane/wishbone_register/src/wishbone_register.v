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
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,
    output wire reg_q_o
);

    reg internal_data;
    assign reg_q_o = internal_data;

    always @ (posedge wb_clk_i or posedge wb_rst_i) begin
        if (wb_rst_i) begin
            internal_data <= 'h0;
            wbs_ack_o <= 'h0;
        end else begin
            wbs_ack_o <= 'h1;

            if (wbs_stb_i && wbs_adr_i == ADDRESS) begin
                if (wbs_we_i == 1'b1) begin
                    internal_data <= wbs_dat_i[0];
                end else if (wbs_we_i == 1'b0) begin
                    wbs_dat_o <= internal_data;
                end 

            end
        end
    end
endmodule