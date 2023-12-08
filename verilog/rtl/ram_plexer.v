module ram_plexer (
    // baby io
    input baby_clk_i,
    input [31:0] baby_addr_i,
    input [31:0] baby_data_i,
    output [31:0] baby_data_o,

    // spi io
    input spi_clk_i, // not to be confused with the actual SPI clock provided externally
    input [31:0] spi_addr_i,
    input [31:0] spi_data_i,
    output [31:0] spi_data_o,

    // wishbone io
    input wb_clk_i,
    input [31:0] wb_addr_i,
    input [31:0] wb_data_i,
    output [31:0] wb_data_o,

    // ram
    output ram_clk_o,
    output [31:0] ram_addr_o,
    output [31:0] ram_data_o,
    input [31:0] ram_data_i,

    // plex
    input baby_halt,
    input spi_cs0,
    input wb_config_en
);

    // plexing states:
    // 
    //    wb_config_en   |   spi_cs0   |  baby_halt  |     action    
    //          0               0             0      |  route baby to ram
    //          0               0             1      |  route baby to ram
    //          0               1             0      |  route baby to ram
    //          0               1             1      |  route spi to ram
    //          1               0             0      |  route baby to ram
    //          1               0             1      |  route wb to ram
    //          1               1             1      |  route baby to ram

    always @ (*) begin

        if (baby_halt) begin
            if (spi_cs0) begin
                ram_clk_o <= spi_clk_i;
                ram_addr_o <= spi_addr_i;
                ram_data_o <= spi_data_i;
                ram_data_i <= spi_data_o;

            end else if (wb_config_en) begin
                ram_clk_o <= wb_clk_i;
                ram_addr_o <= wb_addr_i;
                ram_data_o <= wb_data_i;
                ram_data_i <= wb_data_o;
            end
        end else begin
            ram_clk_o <= baby_clk_i;
            ram_addr_o <= baby_addr_i;
            ram_data_o <= baby_data_i;
            ram_data_i <= baby_data_o;
        end
    end
endmodule