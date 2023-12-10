// module mos_wishbone_interface (
// `ifdef USE_POWER_PINS
//     inout vdd,		// User area 5.0V supply
//     inout vss,		// User area ground
// `endif
//     input wb_clk_i,
//     input wb_rst_i,
//     input wbs_stb_i,
//     input wbs_cyc_i,
//     input wbs_we_i,
//     // input [3:0] wbs_sel_i,
//     input [31:0] wbs_dat_i,
//     input [31:0] wbs_adr_i,
//     output reg wbs_ack_o,
//     output reg [31:0] wbs_dat_o,

//     // input [65:0] decoder_result_i,
//     output [7:0] decoder_instruction_o,
// );    

//     localparam BASE_WISHBONE_ADDRESS = 32'h30000000;
//     localparam INSTRUCTION_REG_ADDR = BASE_WISHBONE_ADDRESS;
//     localparam DECODER_LOW_REG_ADDR = INSTRUCTION_REG_ADDR + 4;
//     localparam DECODER_MID_REG_ADDR = DECODER_LOW_REG_ADDR + 4;
//     localparam DECODER_HI_REG_ADDR  = DECODER_MID_REG_ADDR + 4;

//     wire [31:0] w_instr_wb_data, w_instr_reg_data;
//     wire w_instr_wb_ack;

//     wishbone_register # (
//         .ADDRESS(INSTRUCTION_REG_ADDR)
//     ) wbreg_instr (
//         .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
//         .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i),
//         .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
//         .wbs_ack_o(w_instr_wb_ack),
//         .wbs_dat_o(w_instr_wb_data), 
//         .reg_q_o(w_instr_reg_data)
//     );

//     assign decoder_instruction_o = w_instr_reg_data[7:0];

//     // select what to output
//     always @ (*) begin
//         case (wbs_adr_i)

//             INSTRUCTION_REG_ADDR: begin
//                 wbs_ack_o <= w_instr_wb_ack;
//                 wbs_dat_o <= w_instr_wb_data;
//             end

//             default: begin
//                 wbs_ack_o <= 'h0;
//                 wbs_dat_o <= 'h0;
//             end

//             // DECODER_LOW_REG_ADDR: begin
//             //     wbs_ack_o <= w_wbreg_ack_decoder_low;
//             //     wbs_dat_o <= w_wb_dat_wbreg_decoder_low;
//             // end

//             // DECODER_MID_REG_ADDR: begin
//             //     wbs_ack_o <= w_wbreg_ack_decoder_mid;
//             //     wbs_dat_o <= w_wb_dat_wbreg_decoder_mid;
//             // end

//             // DECODER_HI_REG_ADDR: begin
//             //     wbs_ack_o <= w_wbreg_ack_decoder_hi;
//             //     wbs_dat_o <= w_wb_dat_wbreg_decoder_hi;
//             // end
//         endcase
//     end

// endmodule



module mos_wishbone_interface (
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
    output reg [31:0] wbs_dat_o,

    input [65:0] decoder_result_i,
    output [7:0] decoder_instruction_o,
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

    assign {w_wbreg_decoder_hi[1:0], w_wbreg_decoder_mid, w_wbreg_decoder_low} = decoder_result_i;
    assign decoder_instruction_o = w_wbreg_instruction[7:0];

    // select what to output
    always @ (*) begin
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

            default: begin
                wbs_ack_o <= 'hZ;
                wbs_dat_o <= 'hZ;
            end
        endcase
    end

    wishbone_register # (
        .ADDRESS(INSTRUCTION_REG_ADDR)
    ) wbreg_instr_in (
    .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i),
    .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
    .wbs_ack_o(w_wbreg_ack_instruction),
    .wbs_dat_o(w_wb_dat_wbreg_instruction), 
    .reg_q_o(w_wbreg_instruction)
    );


    wishbone_register # (
        .ADDRESS(DECODER_LOW_REG_ADDR)
    ) wbreg_decoder_low (
    .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i), 
    .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
    .wbs_ack_o(w_wbreg_ack_decoder_low),
    .wbs_dat_o(w_wb_dat_wbreg_decoder_low), 
    .data_i(w_wbreg_decoder_low)
    );

    wishbone_register # (
        .ADDRESS(DECODER_MID_REG_ADDR)
    ) wbreg_decoder_mid (
    .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i), 
    .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
    .wbs_ack_o(w_wbreg_ack_decoder_mid),
    .wbs_dat_o(w_wb_dat_wbreg_decoder_mid), 
    .data_i( w_wbreg_decoder_mid)
    );

    wishbone_register # (
        .ADDRESS(DECODER_HI_REG_ADDR)
    ) wbreg_decoder_hi (
    .wb_clk_i(wb_clk_i), .wb_rst_i(wb_rst_i), .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i), .wbs_we_i(wbs_we_i), 
    .wbs_dat_i(wbs_dat_i), .wbs_adr_i(wbs_adr_i), 
    
    .wbs_ack_o(w_wbreg_ack_decoder_hi),
    .wbs_dat_o(w_wb_dat_wbreg_decoder_hi), 
    .data_i( w_wbreg_decoder_hi)
    );
endmodule