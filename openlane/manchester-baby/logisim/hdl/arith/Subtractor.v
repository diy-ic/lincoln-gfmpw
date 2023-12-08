/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : Subtractor                                                   **
 **                                                                          **
 *****************************************************************************/

module Subtractor( borrowIn,
                   borrowOut,
                   dataA,
                   dataB,
                   result );

   /*******************************************************************************
   ** Here all module parameters are defined with a dummy value                  **
   *******************************************************************************/
   parameter extendedBits = 1;
   parameter nrOfBits = 1;

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input                borrowIn;
   input [nrOfBits-1:0] dataA;
   input [nrOfBits-1:0] dataB;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output                borrowOut;
   output [nrOfBits-1:0] result;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire                    s_carry;
   wire [extendedBits-1:0] s_extendeddataA;
   wire [extendedBits-1:0] s_extendeddataB;
   wire [extendedBits-1:0] s_sumresult;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/
   
   // broken, returns incorrect result
   // assign {s_carry, result} = dataA + ~(dataB) + ~borrowIn;

   // fixed
   assign {s_carry, result} = dataA + ~(dataB) + {{nrOfBits-1{1'b0}}, ~borrowIn};
   assign borrowOut        = ~s_carry;


   // assign s_sumresult = dataA + ~dataB;
   // assign result = s_sumresult[nrOfBits-1:0];
   // assign borrowOut = ~s_sumresult[extendedBits-1];

endmodule
