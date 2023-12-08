/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : LogisimClockComponent                                        **
 **                                                                          **
 *****************************************************************************/

module LogisimClockComponent( clockBus,
                              clockTick,
                              globalClock );

   /*******************************************************************************
   ** Here all module parameters are defined with a dummy value                  **
   *******************************************************************************/
   parameter highTicks = 1;
   parameter lowTicks = 1;
   parameter nrOfBits = 1;
   parameter phase = 1;

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input clockTick;
   input globalClock;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output [4:0] clockBus;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire                s_counterIsZero;
   wire [nrOfBits-1:0] s_counterNext;

   /*******************************************************************************
   ** The registers are defined here                                             **
   *******************************************************************************/
   reg [1:0]          s_bufferRegs;
   reg [nrOfBits-1:0] s_counterValue;
   reg [phase-1:0]    s_derivedClock;
   reg [3:0]          s_outputRegs;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/
   /*******************************************************************************
   ** The output signals are defined here; we synchronize them all on the main   **
   ** clock                                                                      **
   *******************************************************************************/

   assign clockBus = {globalClock,s_outputRegs};
   always @(posedge globalClock)
   begin
      s_bufferRegs[0] <= s_derivedClock[phase - 1];
      s_bufferRegs[1] <= ~s_derivedClock[phase - 1];
      s_outputRegs[0] <= s_bufferRegs[0];
      s_outputRegs[1] <= s_outputRegs[1];
      s_outputRegs[2] <= ~s_bufferRegs[0] & s_derivedClock[phase - 1];
      s_outputRegs[3] <= ~s_derivedClock[phase - 1] & s_bufferRegs[0];
   end

   /*******************************************************************************
   ** The control signals are defined here                                       **
   *******************************************************************************/
   assign s_counterIsZero = (s_counterValue == 0) ? 1'b1 : 1'b0;
   assign s_counterNext = (s_counterIsZero == 1'b0)
                          ? s_counterValue - 1
                          : (s_derivedClock[0] == 1'b1)
                             ? lowTicks - 1
                             : highTicks - 1;

   /*******************************************************************************
   ** The initial values are defined here (for simulation only)                  **
   *******************************************************************************/
   initial
   begin
      s_outputRegs = 0;
      s_derivedClock = 0;
      s_counterValue = 0;
   end

   /*******************************************************************************
   ** The state registers are defined here                                       **
   *******************************************************************************/
   integer n;
   always @(posedge globalClock)
   begin
      if (clockTick)
      begin
         s_derivedClock[0] <= s_derivedClock[0] ^ s_counterIsZero;
         for (n = 1; n < phase; n = n+1) begin
            s_derivedClock[n] <= s_derivedClock[n-1];
         end
      end
   end

   always @(posedge globalClock)
   begin
      if (clockTick)
      begin
         s_counterValue <= s_counterNext;
      end
   end

endmodule
