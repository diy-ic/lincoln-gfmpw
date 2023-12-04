SIM ?= icarus
TOPLEVEL_LANG ?= verilog

RTL_DIR ?= $(shell dirname $(PWD))/src
TEST_DIR ?= $(shell dirname $(PWD))/tb


VERILOG_SOURCES += $(RTL_DIR)/core_interface.sv
VERILOG_SOURCES += $(RTL_DIR)/instruction_handler.sv
VERILOG_SOURCES += $(RTL_DIR)/simple_neuron.sv
VERILOG_SOURCES += $(RTL_DIR)/spi_interface.sv
VERILOG_SOURCES += $(RTL_DIR)/titan.sv

VERILOG_SOURCES += $(TEST_DIR)/tb_core_interface.v
VERILOG_SOURCES += $(TEST_DIR)/tb_instruction_handler.sv
# VERILOG_SOURCES += $(TEST_DIR)/dut_instruction_handler.sv
# VERILOG_SOURCES += $(TEST_DIR)/dut_param_mux.sv

# MODULE refers to python file containing tests
# TOPLEVEL refers to the top level module in the source file

# core interface
test-ci:
	$(MAKE) sim MODULE=test_core_interface TOPLEVEL=tb_core_interface

test-ih:
	$(MAKE) sim MODULE=test_instruction_handler TOPLEVEL=tb_instruction_handler


#   not sure how to tell verilator to use something else for a top-level module, or if its even possible
#   so to support multiple seperate tests we're just going to clean the directory and rebuild every time
clean_test_ci:
	$(MAKE) clean
	$(MAKE) sim MODULE=test_core_interface TOPLEVEL=dut_core_interface

clean_test_ih:
	$(MAKE) clean
	$(MAKE) sim MODULE=test_instruction_handler TOPLEVEL=dut_instruction_handler

clean_test_mux:
	$(MAKE) clean
	$(MAKE) sim MODULE=test_param_mux TOPLEVEL=dut_param_mux

cleaner:
	$(MAKE) clean
	rm *.vcd
	rm results.xml

include $(shell cocotb-config --makefiles)/Makefile.sim
