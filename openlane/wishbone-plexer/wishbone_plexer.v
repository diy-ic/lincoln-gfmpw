module wishbone_plexer(
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply    
    inout vss,		// User area ground
`endif

    input [31:0] wb_adr_i,

    input [31:0] decoder_data_i,
    input decoder_ack_i,

    input [31:0] ram_wb_data_i,
    input ram_wb_ack_i,

    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,
);


   localparam DECODER_START_ADDR =  32'h30000000;
   localparam DECODER_END_ADDR = 32'h30000019;
   localparam RAM_WB_START_ADDR = 32'h30000100;
   localparam RAM_WB_END_ADDR = 32'h30000119;

    always @ (*) begin
        if (wb_adr_i >= DECODER_START_ADDR && wb_adr_i <= DECODER_END_ADDR) begin
            wbs_ack_o <= decoder_ack_i;
            wbs_dat_o <= decoder_data_i;
        end else if (wb_adr_i >= RAM_WB_START_ADDR && wb_adr_i <= RAM_WB_END_ADDR) begin
            wbs_ack_o <= ram_wb_ack_i;
            wbs_dat_o <= ram_wb_data_i;
        end
    end


endmodule