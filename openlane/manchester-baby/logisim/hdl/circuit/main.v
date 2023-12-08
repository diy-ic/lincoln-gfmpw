/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : main                                                         **
 **                                                                          **
 *****************************************************************************/

module main( logisimClockTree0,
             ram_addr_o,
             ram_data_i,
             ram_data_o,
             ram_rw_en_o,
             reset_i,
             stop_lamp_o,
             logisim_clock_tree_0 );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input [4:0]  logisimClockTree0;
   input [31:0] ram_data_i;
   input        reset_i;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output [4:0]  ram_addr_o;
   output [31:0] ram_data_o;
   output        ram_rw_en_o;
   output        stop_lamp_o;
   output logisim_clock_tree_0;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [4:0]  s_logisimBus1;
   wire [31:0] s_logisimBus11;
   wire [4:0]  s_logisimBus13;
   wire [4:0]  s_logisimBus15;
   wire [2:0]  s_logisimBus16;
   wire [4:0]  s_logisimBus17;
   wire [4:0]  s_logisimBus18;
   wire [4:0]  s_logisimBus19;
   wire [31:0] s_logisimBus2;
   wire [4:0]  s_logisimBus22;
   wire [4:0]  s_logisimBus24;
   wire [4:0]  s_logisimBus27;
   wire [31:0] s_logisimBus29;
   wire [4:0]  s_logisimBus30;
   wire [4:0]  s_logisimBus31;
   wire [4:0]  s_logisimBus35;
   wire [31:0] s_logisimBus37;
   wire [31:0] s_logisimBus38;
   wire [4:0]  s_logisimBus4;
   wire [31:0] s_logisimBus42;
   wire [4:0]  s_logisimBus45;
   wire [4:0]  s_logisimBus48;
   wire [4:0]  s_logisimBus5;
   wire [4:0]  s_logisimBus56;
   wire [31:0] s_logisimBus6;
   wire [4:0]  s_logisimBus69;
   wire [4:0]  s_logisimBus70;
   wire [4:0]  s_logisimBus71;
   wire [4:0]  s_logisimBus72;
   wire [4:0]  s_logisimBus73;
   wire [31:0] s_logisimBus74;
   wire [31:0] s_logisimBus75;
   wire [4:0]  s_logisimBus76;
   wire [4:0]  s_logisimBus77;
   wire [4:0]  s_logisimBus78;
   wire [4:0]  s_logisimBus79;
   wire [31:0] s_logisimBus8;
   wire [4:0]  s_logisimBus80;
   wire [31:0] s_logisimBus81;
   wire [31:0] s_logisimBus82;
   wire [4:0]  s_logisimBus83;
   wire        s_logisimNet10;
   wire        s_logisimNet14;
   wire        s_logisimNet20;
   wire        s_logisimNet21;
   wire        s_logisimNet23;
   wire        s_logisimNet25;
   wire        s_logisimNet26;
   wire        s_logisimNet28;
   wire        s_logisimNet3;
   wire        s_logisimNet32;
   wire        s_logisimNet33;
   wire        s_logisimNet34;
   wire        s_logisimNet36;
   wire        s_logisimNet39;
   wire        s_logisimNet40;
   wire        s_logisimNet41;
   wire        s_logisimNet43;
   wire        s_logisimNet47;
   wire        s_logisimNet49;
   wire        s_logisimNet50;
   wire        s_logisimNet51;
   wire        s_logisimNet52;
   wire        s_logisimNet53;
   wire        s_logisimNet54;
   wire        s_logisimNet55;
   wire        s_logisimNet57;
   wire        s_logisimNet58;
   wire        s_logisimNet60;
   wire        s_logisimNet61;
   wire        s_logisimNet62;
   wire        s_logisimNet63;
   wire        s_logisimNet64;
   wire        s_logisimNet65;
   wire        s_logisimNet66;
   wire        s_logisimNet67;
   wire        s_logisimNet68;
   wire        s_logisimNet7;
   wire        s_logisimNet84;
   wire        s_logisimNet85;
   wire        s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** All clock generator connections are defined here                           **
   *******************************************************************************/
   assign s_logisimNet85 = logisimClockTree0[0];
   assign logisim_clock_tree_0 = logisimClockTree0[0];

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus11[31:0] = ram_data_i;
   assign s_logisimNet49       = reset_i;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign ram_addr_o  = s_logisimBus27[4:0];
   assign ram_data_o  = s_logisimBus8[31:0];
   assign ram_rw_en_o = s_logisimNet41;
   assign stop_lamp_o = s_logisimNet47;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // Constant
   assign  s_logisimBus81[31:0]  =  32'h00000000;


   // Constant
   assign  s_logisimBus69[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus70[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus71[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus72[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus73[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus74[31:0]  =  32'h00000000;


   // Constant
   assign  s_logisimBus75[31:0]  =  32'h00000000;


   // Constant
   assign  s_logisimNet84  =  1'b0;


   // Constant
   assign  s_logisimBus82[31:0]  =  32'h00000000;


   // Constant
   assign  s_logisimNet32  =  1'b1;


   // Constant
   assign  s_logisimBus30[4:1]  =  4'h0;


   // Constant
   assign  s_logisimBus83[4:0]  =  {1'b0, 4'h1};


   // Constant
   assign  s_logisimBus76[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus77[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus78[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus79[4:0]  =  {1'b0, 4'h0};


   // Constant
   assign  s_logisimBus80[4:0]  =  {1'b0, 4'h0};


   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   OR_GATE #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet60),
               .input2(s_logisimNet61),
               .result(s_logisimNet33));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet63),
               .input2(s_logisimNet65),
               .result(s_logisimNet3));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet63),
               .input2(s_logisimNet62),
               .result(s_logisimNet41));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet63),
               .input2(s_logisimNet66),
               .result(s_logisimNet40));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet64),
               .input2(s_logisimNet33),
               .result(s_logisimNet28));

   OR_GATE_BUS_5_INPUTS #(.BubblesMask({1'b0, 4'h0}),
                          .NrOfBits(5))
      GATES_6 (.input1(s_logisimBus56[4:0]),
               .input2(s_logisimBus13[4:0]),
               .input3(s_logisimBus22[4:0]),
               .input4(s_logisimBus1[4:0]),
               .input5(s_logisimBus31[4:0]),
               .result(s_logisimBus27[4:0]));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_7 (.input1(s_logisimNet64),
               .input2(s_logisimNet66),
               .result(s_logisimNet7));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_8 (.input1(s_logisimNet64),
               .input2(s_logisimNet65),
               .result(s_logisimNet14));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_9 (.input1(s_logisimNet34),
               .input2(s_logisimNet64),
               .result(s_logisimNet52));

   OR_GATE_BUS #(.BubblesMask(2'b00),
                 .NrOfBits(32))
      GATES_10 (.input1(s_logisimBus2[31:0]),
                .input2(s_logisimBus29[31:0]),
                .result(s_logisimBus37[31:0]));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_11 (.input1(s_logisimNet14),
                .input2(s_logisimNet7),
                .result(s_logisimNet23));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_12 (.input1(s_logisimNet20),
                .input2(s_logisimNet55),
                .result(s_logisimNet66));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_13 (.input1(s_logisimNet85),
                .input2(s_logisimNet43),
                .result(s_logisimNet36));

   OR_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_14 (.input1(s_logisimNet66),
                .input2(s_logisimNet65),
                .input3(s_logisimNet62),
                .result(s_logisimNet53));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_15 (.input1(s_logisimNet60),
                .input2(s_logisimNet68),
                .result(s_logisimNet26));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_16 (.input1(s_logisimNet58),
                .input2(s_logisimNet68),
                .result(s_logisimNet10));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_17 (.input1(s_logisimNet61),
                .input2(s_logisimNet68),
                .result(s_logisimNet39));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_18 (.input1(s_logisimNet53),
                .input2(s_logisimNet68),
                .result(s_logisimNet21));

   OR_GATE_BUS_5_INPUTS #(.BubblesMask({1'b0, 4'h0}),
                          .NrOfBits(5))
      GATES_19 (.input1(s_logisimBus45[4:0]),
                .input2(s_logisimBus17[4:0]),
                .input3(s_logisimBus24[4:0]),
                .input4(s_logisimBus19[4:0]),
                .input5(s_logisimBus5[4:0]),
                .result(s_logisimBus35[4:0]));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_20 (.input1(s_logisimNet67),
                .input2(s_logisimNet68),
                .result(s_logisimNet9));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_21 (.enable(1'b1),
                  .muxIn_0(s_logisimBus69[4:0]),
                  .muxIn_1(s_logisimBus4[4:0]),
                  .muxOut(s_logisimBus56[4:0]),
                  .sel(s_logisimNet57));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_22 (.enable(1'b1),
                  .muxIn_0(s_logisimBus70[4:0]),
                  .muxIn_1(s_logisimBus6[4:0]),
                  .muxOut(s_logisimBus13[4:0]),
                  .sel(s_logisimNet3));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_23 (.enable(1'b1),
                  .muxIn_0(s_logisimBus71[4:0]),
                  .muxIn_1(s_logisimBus6[4:0]),
                  .muxOut(s_logisimBus22[4:0]),
                  .sel(s_logisimNet41));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_24 (.enable(1'b1),
                  .muxIn_0(s_logisimBus72[4:0]),
                  .muxIn_1(s_logisimBus6[4:0]),
                  .muxOut(s_logisimBus1[4:0]),
                  .sel(s_logisimNet40));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_25 (.enable(1'b1),
                  .muxIn_0(s_logisimBus73[4:0]),
                  .muxIn_1(s_logisimBus6[4:0]),
                  .muxOut(s_logisimBus31[4:0]),
                  .sel(s_logisimNet28));

   Multiplexer_bus_2 #(.nrOfBits(32))
      PLEXERS_26 (.enable(1'b1),
                  .muxIn_0(s_logisimBus74[31:0]),
                  .muxIn_1(s_logisimBus38[31:0]),
                  .muxOut(s_logisimBus29[31:0]),
                  .sel(s_logisimNet7));

   Multiplexer_bus_2 #(.nrOfBits(32))
      PLEXERS_27 (.enable(1'b1),
                  .muxIn_0(s_logisimBus75[31:0]),
                  .muxIn_1(s_logisimBus42[31:0]),
                  .muxOut(s_logisimBus2[31:0]),
                  .sel(s_logisimNet14));

   Decoder_8   PLEXERS_28 (.decoderOut_0(s_logisimNet60),
                           .decoderOut_1(s_logisimNet61),
                           .decoderOut_2(s_logisimNet65),
                           .decoderOut_3(s_logisimNet62),
                           .decoderOut_4(s_logisimNet20),
                           .decoderOut_5(s_logisimNet55),
                           .decoderOut_6(s_logisimNet58),
                           .decoderOut_7(s_logisimNet34),
                           .enable(1'b1),
                           .sel(s_logisimBus6[15:13]));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_29 (.enable(1'b1),
                  .muxIn_0(s_logisimBus76[4:0]),
                  .muxIn_1(s_logisimBus15[4:0]),
                  .muxOut(s_logisimBus45[4:0]),
                  .sel(s_logisimNet67));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_30 (.enable(1'b1),
                  .muxIn_0(s_logisimBus77[4:0]),
                  .muxIn_1(s_logisimBus11[4:0]),
                  .muxOut(s_logisimBus17[4:0]),
                  .sel(s_logisimNet26));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_31 (.enable(1'b1),
                  .muxIn_0(s_logisimBus78[4:0]),
                  .muxIn_1(s_logisimBus18[4:0]),
                  .muxOut(s_logisimBus24[4:0]),
                  .sel(s_logisimNet10));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_32 (.enable(1'b1),
                  .muxIn_0(s_logisimBus79[4:0]),
                  .muxIn_1(s_logisimBus48[4:0]),
                  .muxOut(s_logisimBus19[4:0]),
                  .sel(s_logisimNet39));

   Multiplexer_bus_2 #(.nrOfBits(5))
      PLEXERS_33 (.enable(1'b1),
                  .muxIn_0(s_logisimBus80[4:0]),
                  .muxIn_1(s_logisimBus4[4:0]),
                  .muxOut(s_logisimBus5[4:0]),
                  .sel(s_logisimNet21));

   Decoder_8   PLEXERS_34 (.decoderOut_0(s_logisimNet67),
                           .decoderOut_1(s_logisimNet57),
                           .decoderOut_2(s_logisimNet51),
                           .decoderOut_3(s_logisimNet63),
                           .decoderOut_4(s_logisimNet64),
                           .decoderOut_5(s_logisimNet68),
                           .decoderOut_6(s_logisimNet54),
                           .decoderOut_7(s_logisimNet25),
                           .enable(1'b1),
                           .sel(s_logisimBus16[2:0]));

   Subtractor #(.extendedBits(33),
                .nrOfBits(32))
      ARITH_35 (.borrowIn(1'b0),
                .borrowOut(),
                .dataA(s_logisimBus8[31:0]),
                .dataB(s_logisimBus11[31:0]),
                .result(s_logisimBus38[31:0]));

   Subtractor #(.extendedBits(33),
                .nrOfBits(32))
      ARITH_36 (.borrowIn(1'b0),
                .borrowOut(),
                .dataA(s_logisimBus81[31:0]),
                .dataB(s_logisimBus11[31:0]),
                .result(s_logisimBus42[31:0]));

   Comparator #(.nrOfBits(32),
                .twosComplement(1))
      ARITH_37 (.aEqualsB(),
                .aGreaterThanB(),
                .aLessThanB(s_logisimBus30[0]),
                .dataA(s_logisimBus8[31:0]),
                .dataB(s_logisimBus82[31:0]));

   Adder #(.extendedBits(6),
           .nrOfBits(5))
      ARITH_38 (.carryIn(1'b0),
                .carryOut(),
                .dataA(s_logisimBus11[4:0]),
                .dataB(s_logisimBus4[4:0]),
                .result(s_logisimBus48[4:0]));

   Adder #(.extendedBits(6),
           .nrOfBits(5))
      ARITH_39 (.carryIn(1'b0),
                .carryOut(),
                .dataA(s_logisimBus83[4:0]),
                .dataB(s_logisimBus4[4:0]),
                .result(s_logisimBus15[4:0]));

   Adder #(.extendedBits(6),
           .nrOfBits(5))
      ARITH_40 (.carryIn(1'b0),
                .carryOut(),
                .dataA(s_logisimBus4[4:0]),
                .dataB(s_logisimBus30[4:0]),
                .result(s_logisimBus18[4:0]));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(32))
      IR (.clock(logisimClockTree0[4]),
          .clockEnable(s_logisimNet51),
          .d(s_logisimBus11[31:0]),
          .q(s_logisimBus6[31:0]),
          .reset(s_logisimNet49),
          .tick(logisimClockTree0[2]));

   S_R_FLIPFLOP #(.invertClockEnable(0))
      MEMORY_42 (.clock(logisimClockTree0[4]),
                 .preset(1'b0),
                 .q(s_logisimNet47),
                 .qBar(s_logisimNet43),
                 .r(s_logisimNet84),
                 .reset(s_logisimNet49),
                 .s(s_logisimNet52),
                 .tick(logisimClockTree0[2]));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(32))
      Acc (.clock(logisimClockTree0[4]),
           .clockEnable(s_logisimNet23),
           .d(s_logisimBus37[31:0]),
           .q(s_logisimBus8[31:0]),
           .reset(s_logisimNet49),
           .tick(logisimClockTree0[2]));

   LogisimCounter #(.invertClock(0),
                    .maxVal(3'b111),
                    .mode(0),
                    .width(3))
      MEMORY_44 (.clear(s_logisimNet49),
                 .clock(s_logisimNet36),
                 .compareOut(),
                 .countValue(s_logisimBus16[2:0]),
                 .enable(1'b1),
                 .load(1'b0),
                 .loadData(3'd0),
                 .tick(1'b1),
                 .upNotDown(s_logisimNet32));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(5))
      PC (.clock(logisimClockTree0[4]),
          .clockEnable(s_logisimNet9),
          .d(s_logisimBus35[4:0]),
          .q(s_logisimBus4[4:0]),
          .reset(s_logisimNet49),
          .tick(logisimClockTree0[2]));


endmodule
