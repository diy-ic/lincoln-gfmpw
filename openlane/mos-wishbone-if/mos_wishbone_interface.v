module mos_wishbone_interface (
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    // input wbs_cyc_i,
    input wbs_we_i,
    // input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output [31:0] wbs_dat_o

    // input [65:0] decoder_result_i,
    // output reg [7:0] decoder_instruction_o
);

    // decoder output is 66 bits long
    // wishbone registers are 32 bits long
    // naming convention: 
    //   decoder_      hi          mid         low
    //            | 95 --- 64 | 63 --- 32 | 31 --- 0 |
    //                  | bit 65 is the last valid bit
    //            | 95:66 is ignored


    localparam BASE_WISHBONE_ADDRESS = 32'h30000000;
    localparam INSTRUCTION_REG_ADDR = BASE_WISHBONE_ADDRESS;       // 30 00 00 00 -- 03
    localparam DECODER_LOW_REG_ADDR = INSTRUCTION_REG_ADDR + 4;    // 30 00 00 04 -- 07
    localparam DECODER_MID_REG_ADDR = DECODER_LOW_REG_ADDR + 4;    // 30 00 00 08 -- 11
    localparam DECODER_HI_REG_ADDR  = DECODER_MID_REG_ADDR + 4;    // 30 00 00 12 -- 15
    localparam ID_REGISTER = DECODER_HI_REG_ADDR + 4;              // 30 00 00 16 -- 19

    //                               95              64   63              32    31               0
    //                               31               0   31               0    31               0
    reg [31:0] r_wb_data_o;
    assign wbs_dat_o = r_wb_data_o;

    reg [7:0] r_instr;
    wire [65:0] w_decoder_out;    

    always @ (posedge wb_clk_i or posedge wb_rst_i) begin
        
        if (wb_rst_i) begin
            wbs_ack_o <= 'h0;
            r_instr <= 'h0;
        end else begin
            
            // if strobe and if address is greater than or equal to the lowest AND address is less than or equal to the highest
            // this should gives us this wishbone address range
            if (wbs_stb_i && (wbs_adr_i >= INSTRUCTION_REG_ADDR && wbs_adr_i <= ID_REGISTER)) begin
               wbs_ack_o <= 1'b1;

                // if reading
                if (wbs_we_i == 1'b0) begin
                   case (wbs_adr_i)
                        // need to let user read values out
                        INSTRUCTION_REG_ADDR: r_wb_data_o <= {{24{1'b0}}, r_instr};
                        DECODER_LOW_REG_ADDR: r_wb_data_o <= w_decoder_out[31:0];
                        DECODER_MID_REG_ADDR: r_wb_data_o <= w_decoder_out[63:32];
                        DECODER_HI_REG_ADDR: r_wb_data_o <= {{30{1'b0}}, w_decoder_out[65:64]};
                        ID_REGISTER: r_wb_data_o <= 32'hB000DEAD; // boo! dead
                    endcase

                // if writing
                end else if (wbs_we_i == 1'b1) begin
            
                    case (wbs_adr_i)
                        // need to let user write to instruction, but never the decoder regs
                        // decoder "regs" are for the decoder to use
                        INSTRUCTION_REG_ADDR: r_instr <= wbs_dat_i[7:0];
                        // DECODER_LOW_REG_ADDR: memory[1] <= wbs_dat_i;
                        // DECODER_MID_REG_ADDR: memory[2] <= wbs_dat_i;
                        // DECODER_HI_REG_ADDR: memory[3] <= wbs_dat_i;
                    endcase
                end
            end 
        end
    end

    mos6502_decoder decoder (
        .instruction_i(r_instr),
        .decoded_instruction_o(w_decoder_out)
    );

endmodule