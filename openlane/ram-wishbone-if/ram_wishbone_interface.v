module ram_wishbone_interface (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_we_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,

    output reg ram_wb_active,
    output reg ram_wb_we_o,
    output reg [4:0] ram_wb_addr,
    output reg [31:0] ram_wb_data_to_ram,
    input [31:0] ram_wb_data_from_ram
);

    // 30'00'00'00 - 30'00'00'19 already taken by decoder on wishbone
    // or is it 30'00'00'20?
    // either way we'll just change a byte to make sure

    localparam NEXT_VALID_WISHBONE_ADDRESS = 32'h30000100;
    localparam MUX_ENABLE_ACCESS_ADDR = NEXT_VALID_WISHBONE_ADDRESS;     // 30 00 01 00 -- 03
    localparam RAM_ADDRESS_ADDR = MUX_ENABLE_ACCESS_ADDR + 4;            // 30 00 01 04 -- 07
    localparam DATA_TO_RAM_ADDR = RAM_ADDRESS_ADDR + 4;                  // 30 00 01 08 -- 11
    localparam DATA_FROM_RAM_ADDR  = DATA_TO_RAM_ADDR + 4;               // 30 00 01 12 -- 15
    localparam ID_REGISTER = DATA_FROM_RAM_ADDR + 4;                     // 30 00 01 16 -- 19
  

    always @ (posedge wb_clk_i or posedge wb_rst_i) begin
        
        if (wb_rst_i) begin
            wbs_ack_o <= 'h0;
        end else begin
            
            // if strobe and if address is greater than or equal to the lowest AND address is less than or equal to the highest
            // this should gives us this wishbone address range
            if (wbs_stb_i && (wbs_adr_i >= MUX_ENABLE_ACCESS_ADDR && wbs_adr_i <= ID_REGISTER)) begin
               wbs_ack_o <= 1'b1;

                // if reading
                if (wbs_we_i == 1'b0) begin
                   case (wbs_adr_i)
                        // need to let user read values out
                        MUX_ENABLE_ACCESS_ADDR: wbs_dat_o <= {30'h0, ram_wb_we_o, ram_wb_active};
                        RAM_ADDRESS_ADDR: wbs_dat_o <= {27'b0, ram_wb_addr};
                        DATA_TO_RAM_ADDR: wbs_dat_o <= ram_wb_data_to_ram;
                        DATA_FROM_RAM_ADDR: wbs_dat_o <= ram_wb_data_from_ram;
                        ID_REGISTER: wbs_dat_o <= 32'hBAAAAAAD;

                    endcase

                // if writing
                end else if (wbs_we_i == 1'b1) begin
                    case (wbs_adr_i)
                        MUX_ENABLE_ACCESS_ADDR: {ram_wb_we_o, ram_wb_active} <= wbs_dat_i[1:0];
                        RAM_ADDRESS_ADDR: ram_wb_addr <= wbs_dat_i[4:0];
                        DATA_TO_RAM_ADDR: ram_wb_data_to_ram = wbs_dat_i;
                    endcase
                end
            end 
        end
    end
endmodule