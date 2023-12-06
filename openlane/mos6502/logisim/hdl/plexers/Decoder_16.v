/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : Decoder_16                                                   **
 **                                                                          **
 *****************************************************************************/

module Decoder_16( decoderOut_0,
                   decoderOut_1,
                   decoderOut_10,
                   decoderOut_11,
                   decoderOut_12,
                   decoderOut_13,
                   decoderOut_14,
                   decoderOut_15,
                   decoderOut_2,
                   decoderOut_3,
                   decoderOut_4,
                   decoderOut_5,
                   decoderOut_6,
                   decoderOut_7,
                   decoderOut_8,
                   decoderOut_9,
                   enable,
                   sel );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input       enable;
   input [3:0] sel;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output decoderOut_0;
   output decoderOut_1;
   output decoderOut_10;
   output decoderOut_11;
   output decoderOut_12;
   output decoderOut_13;
   output decoderOut_14;
   output decoderOut_15;
   output decoderOut_2;
   output decoderOut_3;
   output decoderOut_4;
   output decoderOut_5;
   output decoderOut_6;
   output decoderOut_7;
   output decoderOut_8;
   output decoderOut_9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/
   assign decoderOut_0  = (enable&(sel == 4'h0)) ? 1'b1 : 1'b0;
   assign decoderOut_1  = (enable&(sel == 4'h1)) ? 1'b1 : 1'b0;
   assign decoderOut_2  = (enable&(sel == 4'h2)) ? 1'b1 : 1'b0;
   assign decoderOut_3  = (enable&(sel == 4'h3)) ? 1'b1 : 1'b0;
   assign decoderOut_4  = (enable&(sel == 4'h4)) ? 1'b1 : 1'b0;
   assign decoderOut_5  = (enable&(sel == 4'h5)) ? 1'b1 : 1'b0;
   assign decoderOut_6  = (enable&(sel == 4'h6)) ? 1'b1 : 1'b0;
   assign decoderOut_7  = (enable&(sel == 4'h7)) ? 1'b1 : 1'b0;
   assign decoderOut_8  = (enable&(sel == 4'h8)) ? 1'b1 : 1'b0;
   assign decoderOut_9  = (enable&(sel == 4'h9)) ? 1'b1 : 1'b0;
   assign decoderOut_10 = (enable&(sel == 4'hA)) ? 1'b1 : 1'b0;
   assign decoderOut_11 = (enable&(sel == 4'hB)) ? 1'b1 : 1'b0;
   assign decoderOut_12 = (enable&(sel == 4'hC)) ? 1'b1 : 1'b0;
   assign decoderOut_13 = (enable&(sel == 4'hD)) ? 1'b1 : 1'b0;
   assign decoderOut_14 = (enable&(sel == 4'hE)) ? 1'b1 : 1'b0;
   assign decoderOut_15 = (enable&(sel == 4'hF)) ? 1'b1 : 1'b0;
endmodule
