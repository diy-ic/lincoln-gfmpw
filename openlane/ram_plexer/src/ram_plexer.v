module ram_plexer (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    // baby io
    input baby_clk_i,
    input [31:0] baby_addr_i,
    input [31:0] baby_data_i,
    output reg [31:0] baby_data_o,

    // spi io
    input spi_clk_i, // not to be confused with the actual SPI clock provided externally
    input [31:0] spi_addr_i,
    input [31:0] spi_data_i,
    output reg [31:0] spi_data_o,

    // wishbone io
    input wb_clk_i,
    input [31:0] wb_addr_i,
    input [31:0] wb_data_i,
    output reg [31:0] wb_data_o,

    // ram
    output reg ram_clk_o,
    output reg [31:0] ram_addr_o,
    output reg [31:0] ram_data_o,
    input [31:0] ram_data_i,

    // plex
    input baby_halt,
    input spi_cs,
    input wb_config_en
);

    // plexing states:
    // 
    //    wb_config_en   |   spi_cs    |  baby_halt  |     action    
    //          0               0             0      |  route baby to ram
    //          0               0             1      |  route baby to ram
    //          0               1             0      |  route baby to ram
    //          0               1             1      |  route spi to ram
    //          1               0             0      |  route baby to ram
    //          1               0             1      |  route wb to ram
    //          1               1             1      |  route baby to ram

    /*
                               ________
        spi clk ----------->  |        | --------> ram clk o
        spi addr ---------->  |        | --------> ram addr o
        spi data i -------->  |        | --------> ram data o
        spi data o <--------  |________| <-------  ram data i
    
    */

assign baby_data_o = ram_data_i;
assign wb_data_o = ram_data_i;
assign spi_data_o = ram_data_i;

always @ (*) begin
    case ({wb_config_en, spi_cs, baby_halt})

        // no halt
        3'b000: begin
            ram_addr_o <= baby_addr_i;
            ram_data_o <= baby_data_i;
            ram_clk_o <= baby_clk_i;
        end

        // halt + spi cs
        3'b011: begin
            ram_addr_o <= spi_addr_i;
            ram_data_o <= spi_data_i;
            ram_clk_o <= spi_clk_i;
        end

        3'b101: begin
            ram_addr_o <= wb_addr_i;
            ram_data_o <= wb_data_i;
            ram_clk_o <= wb_clk_i;
        end

        default: begin
            ram_addr_o <= baby_addr_i;
            ram_data_o <= baby_data_i;
            ram_clk_o <= baby_clk_i;
        end
    endcase
end

endmodule