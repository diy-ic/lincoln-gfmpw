// used to verify with modelsim
module tb_manchester_baby();

    
    reg clock = 1'b0;
    always #10 clock = ~clock;
    
    reg reset_i;
    wire ram_rw_en_o, stop_lamp_o, logisim_clock_tree_0_out;
    wire [31:0] ram_data_io;
    wire [4:0] ram_addr_o;

    // dummy program
    reg [31:0] program_memory [0:31] = '{
        32'h00000013, 32'h0000401f, 32'h0000601f, 32'h0000401f,
        32'h0000801e, 32'h0000c000, 32'h00000000, 32'h0000401f,
        32'h0000601f, 32'h0000401c, 32'h0000801c, 32'h0000601c,
        32'h0000401f, 32'h0000801f, 32'h0000601f, 32'h0000401c,
        32'h0000601c, 32'h0000c000, 32'h0000001a, 32'h0000e000,
        32'h0000601f, 32'h0000401d, 32'h0000801c, 32'h0000801c,
        32'h0000601c, 32'h0000001b, 32'h00000002, 32'h0000000b,
        32'h00000000, 32'h20000000, 32'h00000014, 32'h00000024};

    openlane_manchester_baby uut_manchester_baby (
        .clock(clock), .reset_i(reset_i), .ram_data_io(ram_data_io),
        .ram_addr_o(ram_addr_o), .ram_rw_en_o(ram_rw_en_o), .stop_lamp_o(stop_lamp_o),
        .logisim_clock_tree_0_out(logisim_clock_tree_0_out)
    );


    initial begin
        $dumpfile("waves_tb_manchester_baby_modelsim.vcd");
        $dumpvars(0, uut_manchester_baby);

        // reset baby to known good state
        reset_i = 1'b1;
        #20;
        reset_i = 1'b0;
    end

    reg [31:0] r_temp_io;
    assign ram_data_io = ram_rw_en_o == 1'b0 ? r_temp_io : 'hz;

    always @(posedge logisim_clock_tree_0_out) begin
        if (ram_rw_en_o == 1'b0) begin
            $display("(%g) read: addr %h : %h", $time, ram_addr_o, program_memory[ram_addr_o]);
            r_temp_io <= program_memory[ram_addr_o];

        end else if (ram_rw_en_o == 1'b1) begin
            $display("(%g) write: addr %h : %h", $time, ram_addr_o, ram_data_io);
            program_memory[ram_addr_o] <= ram_data_io;

        end
    end

    always @(posedge stop_lamp_o) begin
        $display("simulation finished at time %g - stop lamp on", $time);
        $finish();
    end

endmodule