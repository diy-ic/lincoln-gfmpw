module ram_plexer (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    // baby io
    input baby_clk_i,
    input baby_we_i,
    input [4:0] baby_addr_i,
    input [31:0] baby_data_i,
    output reg [31:0] baby_data_o,

    // spi io
    input spi_clk_i, // not to be confused with the actual SPI clock provided externally
    input spi_we_i,
    input [4:0] spi_addr_i,
    input [31:0] spi_data_i,
    output reg [31:0] spi_data_o,

    // wishbone io
    input ram_wb_clk_i,
    input ram_wb_we_i,
    input [4:0] ram_wb_addr_i,
    input [31:0] ram_wb_data_i,
    output reg [31:0] ram_wb_data_o,

    // ram
    output reg ram_clk_o,
    output reg ram_we_o,
    output reg [4:0] ram_addr_o,
    output reg [31:0] ram_data_o,
    input [31:0] ram_data_i,

    // plex
    input baby_halt,
    input spi_cs,
    input ram_wb_config_en
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
assign ram_wb_data_o = ram_data_i;
assign spi_data_o = ram_data_i;

always @ (*) begin
    case ({ram_wb_config_en, spi_cs, baby_halt})
    // case ({1'b0, spi_cs, baby_halt})

        // no halt
        3'b000: begin
            ram_addr_o <= baby_addr_i;
            ram_data_o <= baby_data_i;
            ram_clk_o <= baby_clk_i;
            ram_we_o <= baby_we_i;
        end

        // halt + spi cs
        3'b011: begin
            ram_addr_o <= spi_addr_i;
            ram_data_o <= spi_data_i;
            ram_clk_o <= spi_clk_i;
            ram_we_o <= spi_we_i;
        end

        // halt + wb_config_en
        3'b101: begin
            ram_addr_o <= ram_wb_addr_i;
            ram_data_o <= ram_wb_data_i;
            ram_clk_o <= ram_wb_clk_i;
            ram_we_o <= ram_wb_we_i;
        end

        // default let baby control ram
        default: begin
            ram_addr_o <= baby_addr_i;
            ram_data_o <= baby_data_i;
            ram_clk_o <= baby_clk_i;
        end
    endcase
end

endmodule