/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : logisimTopLevelShell                                         **
 **                                                                          **
 *****************************************************************************/

module logisimTopLevelShell( ADC_0,
                             AND_0,
                             ASL_0,
                             A_0,
                             BCC_0,
                             BCS_0,
                             BEQ_0,
                             BMI_0,
                             BNE_0,
                             BPL_0,
                             BRK_0,
                             BVC_0,
                             BVS_0,
                             CLC_0,
                             CLD_0,
                             CLI_0,
                             CLV_0,
                             CMP_0,
                             CPX_0,
                             CPY_0,
                             DEC_0,
                             DES_0,
                             DEY_0,
                             EOR_0,
                             INC_0,
                             INX_0,
                             INY_0,
                             JMP_0,
                             JSR_0,
                             LDA_0,
                             LDX_0,
                             LDX_Y_0,
                             LDY_0,
                             LSR_0,
                             ORA_0,
                             PHA_0,
                             PHP_0,
                             PLA_0,
                             PLP_0,
                             ROL_0,
                             ROR_0,
                             RTI_0,
                             RTS_0,
                             SBC_0,
                             SEC_0,
                             SED_0,
                             SEI_0,
                             STA_0,
                             STX_0,
                             STY_0,
                             TAX_0,
                             TAY_0,
                             TKA_0,
                             TKS_0,
                             TSX_0,
                             TYA_0,
                             Xind_0,
                             absX_0,
                             absY_0,
                             abs_0,
                             hash_0,
                             indY_0,
                             ind_0,
                             instruction_bus_0,
                             instruction_bus_1,
                             instruction_bus_2,
                             instruction_bus_3,
                             instruction_bus_4,
                             instruction_bus_5,
                             instruction_bus_6,
                             instruction_bus_7,
                             rel_0,
                             zpgX_0,
                             zpg_0 );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input instruction_bus_0;
   input instruction_bus_1;
   input instruction_bus_2;
   input instruction_bus_3;
   input instruction_bus_4;
   input instruction_bus_5;
   input instruction_bus_6;
   input instruction_bus_7;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output ADC_0;
   output AND_0;
   output ASL_0;
   output A_0;
   output BCC_0;
   output BCS_0;
   output BEQ_0;
   output BMI_0;
   output BNE_0;
   output BPL_0;
   output BRK_0;
   output BVC_0;
   output BVS_0;
   output CLC_0;
   output CLD_0;
   output CLI_0;
   output CLV_0;
   output CMP_0;
   output CPX_0;
   output CPY_0;
   output DEC_0;
   output DES_0;
   output DEY_0;
   output EOR_0;
   output INC_0;
   output INX_0;
   output INY_0;
   output JMP_0;
   output JSR_0;
   output LDA_0;
   output LDX_0;
   output LDX_Y_0;
   output LDY_0;
   output LSR_0;
   output ORA_0;
   output PHA_0;
   output PHP_0;
   output PLA_0;
   output PLP_0;
   output ROL_0;
   output ROR_0;
   output RTI_0;
   output RTS_0;
   output SBC_0;
   output SEC_0;
   output SED_0;
   output SEI_0;
   output STA_0;
   output STX_0;
   output STY_0;
   output TAX_0;
   output TAY_0;
   output TKA_0;
   output TKS_0;
   output TSX_0;
   output TYA_0;
   output Xind_0;
   output absX_0;
   output absY_0;
   output abs_0;
   output hash_0;
   output indY_0;
   output ind_0;
   output rel_0;
   output zpgX_0;
   output zpg_0;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire       s_A;
   wire       s_ADC;
   wire       s_AND;
   wire       s_ASL;
   wire       s_BCC;
   wire       s_BCS;
   wire       s_BEQ;
   wire       s_BMI;
   wire       s_BNE;
   wire       s_BPL;
   wire       s_BRK;
   wire       s_BVC;
   wire       s_BVS;
   wire       s_CLC;
   wire       s_CLD;
   wire       s_CLI;
   wire       s_CLV;
   wire       s_CMP;
   wire       s_CPX;
   wire       s_CPY;
   wire       s_DEC;
   wire       s_DES;
   wire       s_DEY;
   wire       s_EOR;
   wire       s_INC;
   wire       s_INX;
   wire       s_INY;
   wire       s_JMP;
   wire       s_JSR;
   wire       s_LDA;
   wire       s_LDX;
   wire       s_LDX_Y;
   wire       s_LDY;
   wire       s_LSR;
   wire       s_ORA;
   wire       s_PHA;
   wire       s_PHP;
   wire       s_PLA;
   wire       s_PLP;
   wire       s_ROL;
   wire       s_ROR;
   wire       s_RTI;
   wire       s_RTS;
   wire       s_SBC;
   wire       s_SEC;
   wire       s_SED;
   wire       s_SEI;
   wire       s_STA;
   wire       s_STX;
   wire       s_STY;
   wire       s_TAX;
   wire       s_TAY;
   wire       s_TKA;
   wire       s_TKS;
   wire       s_TSX;
   wire       s_TYA;
   wire       s_Xind;
   wire       s_abs;
   wire       s_absX;
   wire       s_absY;
   wire       s_hash;
   wire       s_ind;
   wire       s_indY;
   wire [7:0] s_instruction_bus;
   wire       s_rel;
   wire       s_zpg;
   wire       s_zpgX;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** All signal adaptations are performed here                                  **
   *******************************************************************************/
   assign ADC_0                = s_ADC;
   assign AND_0                = s_AND;
   assign ASL_0                = s_ASL;
   assign A_0                  = s_A;
   assign BCC_0                = s_BCC;
   assign BCS_0                = s_BCS;
   assign BEQ_0                = s_BEQ;
   assign BMI_0                = s_BMI;
   assign BNE_0                = s_BNE;
   assign BPL_0                = s_BPL;
   assign BRK_0                = s_BRK;
   assign BVC_0                = s_BVC;
   assign BVS_0                = s_BVS;
   assign CLC_0                = s_CLC;
   assign CLD_0                = s_CLD;
   assign CLI_0                = s_CLI;
   assign CLV_0                = s_CLV;
   assign CMP_0                = s_CMP;
   assign CPX_0                = s_CPX;
   assign CPY_0                = s_CPY;
   assign DEC_0                = s_DEC;
   assign DES_0                = s_DES;
   assign DEY_0                = s_DEY;
   assign EOR_0                = s_EOR;
   assign INC_0                = s_INC;
   assign INX_0                = s_INX;
   assign INY_0                = s_INY;
   assign JMP_0                = s_JMP;
   assign JSR_0                = s_JSR;
   assign LDA_0                = s_LDA;
   assign LDX_0                = s_LDX;
   assign LDX_Y_0              = s_LDX_Y;
   assign LDY_0                = s_LDY;
   assign LSR_0                = s_LSR;
   assign ORA_0                = s_ORA;
   assign PHA_0                = s_PHA;
   assign PHP_0                = s_PHP;
   assign PLA_0                = s_PLA;
   assign PLP_0                = s_PLP;
   assign ROL_0                = s_ROL;
   assign ROR_0                = s_ROR;
   assign RTI_0                = s_RTI;
   assign RTS_0                = s_RTS;
   assign SBC_0                = s_SBC;
   assign SEC_0                = s_SEC;
   assign SED_0                = s_SED;
   assign SEI_0                = s_SEI;
   assign STA_0                = s_STA;
   assign STX_0                = s_STX;
   assign STY_0                = s_STY;
   assign TAX_0                = s_TAX;
   assign TAY_0                = s_TAY;
   assign TKA_0                = s_TKA;
   assign TKS_0                = s_TKS;
   assign TSX_0                = s_TSX;
   assign TYA_0                = s_TYA;
   assign Xind_0               = s_Xind;
   assign absX_0               = s_absX;
   assign absY_0               = s_absY;
   assign abs_0                = s_abs;
   assign hash_0               = s_hash;
   assign indY_0               = s_indY;
   assign ind_0                = s_ind;
   assign rel_0                = s_rel;
   assign s_instruction_bus[0] = instruction_bus_0;
   assign s_instruction_bus[1] = instruction_bus_1;
   assign s_instruction_bus[2] = instruction_bus_2;
   assign s_instruction_bus[3] = instruction_bus_3;
   assign s_instruction_bus[4] = instruction_bus_4;
   assign s_instruction_bus[5] = instruction_bus_5;
   assign s_instruction_bus[6] = instruction_bus_6;
   assign s_instruction_bus[7] = instruction_bus_7;
   assign zpgX_0               = s_zpgX;
   assign zpg_0                = s_zpg;

   /*******************************************************************************
   ** The toplevel component is connected here                                   **
   *******************************************************************************/
   main   CIRCUIT_0 (.A(s_A),
                     .ADC(s_ADC),
                     .AND(s_AND),
                     .ASL(s_ASL),
                     .BCC(s_BCC),
                     .BCS(s_BCS),
                     .BEQ(s_BEQ),
                     .BMI(s_BMI),
                     .BNE(s_BNE),
                     .BPL(s_BPL),
                     .BRK(s_BRK),
                     .BVC(s_BVC),
                     .BVS(s_BVS),
                     .CLC(s_CLC),
                     .CLD(s_CLD),
                     .CLI(s_CLI),
                     .CLV(s_CLV),
                     .CMP(s_CMP),
                     .CPX(s_CPX),
                     .CPY(s_CPY),
                     .DEC(s_DEC),
                     .DES(s_DES),
                     .DEY(s_DEY),
                     .EOR(s_EOR),
                     .INC(s_INC),
                     .INX(s_INX),
                     .INY(s_INY),
                     .JMP(s_JMP),
                     .JSR(s_JSR),
                     .LDA(s_LDA),
                     .LDX(s_LDX),
                     .LDX_Y(s_LDX_Y),
                     .LDY(s_LDY),
                     .LSR(s_LSR),
                     .ORA(s_ORA),
                     .PHA(s_PHA),
                     .PHP(s_PHP),
                     .PLA(s_PLA),
                     .PLP(s_PLP),
                     .ROL(s_ROL),
                     .ROR(s_ROR),
                     .RTI(s_RTI),
                     .RTS(s_RTS),
                     .SBC(s_SBC),
                     .SEC(s_SEC),
                     .SED(s_SED),
                     .SEI(s_SEI),
                     .STA(s_STA),
                     .STX(s_STX),
                     .STY(s_STY),
                     .TAX(s_TAX),
                     .TAY(s_TAY),
                     .TKA(s_TKA),
                     .TKS(s_TKS),
                     .TSX(s_TSX),
                     .TYA(s_TYA),
                     .Xind(s_Xind),
                     .abs(s_abs),
                     .absX(s_absX),
                     .absY(s_absY),
                     .hash(s_hash),
                     .ind(s_ind),
                     .indY(s_indY),
                     .instruction_bus(s_instruction_bus),
                     .rel(s_rel),
                     .zpg(s_zpg),
                     .zpgX(s_zpgX));
endmodule
