module mos6502_decoder (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o
);

    // decoder output is 66 bits long
    // wishbone registers are 32 bits long
    // naming convention: 
    //   decoder_      hi          mid         low
    //            | 95 --- 64 | 63 --- 32 | 31 --- 0 |
    //                  | bit 65 is the last valid bit
    //            | 95:66 is ignored

    // wishbone address mapping
    // 30'00'00'00 : decoder instruction input
    //          01 : decoder output (low 4 bytes)
    //          02 : decoder output (mid 4 bytes)
    //          03 : decoder output (high 4 bytes, only 2 bits valid)


    localparam BASE_WISHBONE_ADDRESS = 32'h30000000;
    localparam INSTRUCTION_REG_ADDR = BASE_WISHBONE_ADDRESS;
    localparam DECODER_LOW_REG_ADDR = INSTRUCTION_REG_ADDR + 4;
    localparam DECODER_MID_REG_ADDR = DECODER_LOW_REG_ADDR + 4;
    localparam DECODER_HI_REG_ADDR  = DECODER_MID_REG_ADDR + 4;

    //                               95              64   63              32    31               0
    //                               31               0   31               0    31               0
    wire [31:0] w_wbreg_instruction, w_wbreg_decoder_hi,  w_wbreg_decoder_mid,  w_wbreg_decoder_low;
    assign w_wbreg_decoder_hi[31:2] = 'h0; // assign rest of wire to be zero because we dont need it

    // wishbone data wires coming from the individual registers
    wire [31:0] w_wb_dat_wbreg_instruction, w_wb_dat_wbreg_decoder_low, w_wb_dat_wbreg_decoder_mid, w_wb_dat_wbreg_decoder_hi; 

    // wishbone acknowlege wires coming from the individual registers
    wire w_wbreg_ack_instruction, w_wbreg_ack_decoder_low, w_wbreg_ack_decoder_mid, w_wbreg_ack_decoder_hi;

    always @ (posedge wb_clk_i) begin
        case (wbs_adr_i)

            INSTRUCTION_REG_ADDR: begin
                wbs_ack_o <= w_wbreg_ack_instruction;
                wbs_dat_o <= w_wb_dat_wbreg_instruction;
            end

            DECODER_LOW_REG_ADDR: begin
                wbs_ack_o <= w_wbreg_ack_decoder_low;
                wbs_dat_o <= w_wb_dat_wbreg_decoder_low;
            end

            DECODER_MID_REG_ADDR: begin
                wbs_ack_o <= w_wbreg_ack_decoder_mid;
                wbs_dat_o <= w_wb_dat_wbreg_decoder_mid;
            end

            DECODER_HI_REG_ADDR: begin
                wbs_ack_o <= w_wbreg_ack_decoder_hi;
                wbs_dat_o <= w_wb_dat_wbreg_decoder_hi;
            end
        endcase
    end

    wishbone_register # (
        .ADDRESS(INSTRUCTION_REG_ADDR)
    ) wbreg_instr_in (
    .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i), .wbs_sel_i(wbs_sel_i),
    .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
    .wbs_ack_o(w_wbreg_ack_instruction),
    .wbs_dat_o(w_wb_dat_wbreg_instruction), 
    .reg_q_o(w_wbreg_instruction)
    );

    wishbone_register # (
        .ADDRESS(DECODER_LOW_REG_ADDR)
    ) wbreg_decoder_low (
    .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i), .wbs_sel_i(wbs_sel_i),
    .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
    .wbs_ack_o(w_wbreg_ack_decoder_low),
    .wbs_dat_o(w_wb_dat_wbreg_decoder_low), 
    .data_i(w_wbreg_decoder_low)
    );

    wishbone_register # (
        .ADDRESS(DECODER_MID_REG_ADDR)
    ) wbreg_decoder_mid (
    .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i), .wbs_sel_i(wbs_sel_i),
    .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
    .wbs_ack_o(w_wbreg_ack_decoder_mid),
    .wbs_dat_o(w_wb_dat_wbreg_decoder_mid), 
    .data_i( w_wbreg_decoder_mid)
    );

    wishbone_register # (
        .ADDRESS(DECODER_HI_REG_ADDR)
    ) wbreg_decoder_hi (
    .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i), .wbs_sel_i(wbs_sel_i),
    .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
    .wbs_ack_o(w_wbreg_ack_decoder_hi),
    .wbs_dat_o(w_wb_dat_wbreg_decoder_hi), 
    .data_i( w_wbreg_decoder_hi)
    );


    mos6502_decoder_wrapper decoder_unit (
        .instruction_i(w_wbreg_instruction[7:0]),
        .decoded_instruction_o({w_wbreg_decoder_hi[1:0], w_wbreg_decoder_mid, w_wbreg_decoder_low})
    );

endmodule


module mos6502_decoder_wrapper (
// `ifdef USE_POWER_PINS
//     inout vdd,		// User area 5.0V supply
//     inout vss,		// User area ground
// `endif
    input [7:0] instruction_i,
    output [65:0] decoded_instruction_o
);

    logisimTopLevelShell decoder (
        .instruction_bus_0(instruction_i[0]),
        .instruction_bus_1(instruction_i[1]),
        .instruction_bus_2(instruction_i[2]),
        .instruction_bus_3(instruction_i[3]),
        .instruction_bus_4(instruction_i[4]),
        .instruction_bus_5(instruction_i[5]),
        .instruction_bus_6(instruction_i[6]),
        .instruction_bus_7(instruction_i[7]),

        .ADC_0(decoded_instruction_o[0]),
        .AND_0(decoded_instruction_o[1]),
        .ASL_0(decoded_instruction_o[2]),
        .BCC_0(decoded_instruction_o[4]),
        .BCS_0(decoded_instruction_o[5]),
        .BEQ_0(decoded_instruction_o[6]),
        .BMI_0(decoded_instruction_o[7]),
        .BNE_0(decoded_instruction_o[8]),
        .BPL_0(decoded_instruction_o[9]),
        .BRK_0(decoded_instruction_o[10]),
        .BVC_0(decoded_instruction_o[11]),
        .BVS_0(decoded_instruction_o[12]),
        .CLC_0(decoded_instruction_o[13]),
        .CLD_0(decoded_instruction_o[14]),
        .CLI_0(decoded_instruction_o[15]),
        .CLV_0(decoded_instruction_o[16]),
        .CMP_0(decoded_instruction_o[17]),
        .CPX_0(decoded_instruction_o[18]),
        .CPY_0(decoded_instruction_o[19]),
        .DEC_0(decoded_instruction_o[20]),
        .DES_0(decoded_instruction_o[21]),
        .DEY_0(decoded_instruction_o[22]),
        .EOR_0(decoded_instruction_o[23]),
        .INC_0(decoded_instruction_o[24]),
        .INX_0(decoded_instruction_o[25]),
        .INY_0(decoded_instruction_o[26]),
        .JMP_0(decoded_instruction_o[27]),
        .JSR_0(decoded_instruction_o[28]),
        .LDA_0(decoded_instruction_o[29]),
        .LDX_0(decoded_instruction_o[30]),
        .LDX_Y_0(decoded_instruction_o[31]),
        .LDY_0(decoded_instruction_o[32]),
        .LSR_0(decoded_instruction_o[33]),
        .ORA_0(decoded_instruction_o[34]),
        .PHA_0(decoded_instruction_o[35]),
        .PHP_0(decoded_instruction_o[36]),
        .PLA_0(decoded_instruction_o[37]),
        .PLP_0(decoded_instruction_o[38]),
        .ROL_0(decoded_instruction_o[39]),
        .ROR_0(decoded_instruction_o[40]),
        .RTI_0(decoded_instruction_o[41]),
        .RTS_0(decoded_instruction_o[42]),
        .SBC_0(decoded_instruction_o[43]),
        .SEC_0(decoded_instruction_o[44]),
        .SED_0(decoded_instruction_o[45]),
        .SEI_0(decoded_instruction_o[46]),
        .STA_0(decoded_instruction_o[47]),
        .STX_0(decoded_instruction_o[48]),
        .STY_0(decoded_instruction_o[49]),
        .TAX_0(decoded_instruction_o[50]),
        .TAY_0(decoded_instruction_o[51]),
        .TKA_0(decoded_instruction_o[52]),
        .TKS_0(decoded_instruction_o[53]),
        .TSX_0(decoded_instruction_o[54]),
        .TYA_0(decoded_instruction_o[55]),
        .A_0(decoded_instruction_o[3]),
        .Xind_0(decoded_instruction_o[56]),
        .absX_0(decoded_instruction_o[57]),
        .absY_0(decoded_instruction_o[58]),
        .abs_0(decoded_instruction_o[59]),
        .hash_0(decoded_instruction_o[60]),
        .indY_0(decoded_instruction_o[61]),
        .ind_0(decoded_instruction_o[62]),
        .rel_0(decoded_instruction_o[63]),
        .zpgX_0(decoded_instruction_o[64]),
        .zpg_0(decoded_instruction_o[65])
    );

endmodule