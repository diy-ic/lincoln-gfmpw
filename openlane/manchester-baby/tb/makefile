# SIM ?= verilator
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
# --Wno-combdly needed due to logisim
# --Wno-unoptflat due to "circular logic", caused by ram_data_io assignments
# EXTRA_ARGS += --trace --trace-structs --timing -Wno-width --Wno-unsigned --Wno-combdly --Wno-unoptflat --Wno-latch

RTL_DIR ?= $(shell dirname $(PWD))/src
LOGISIM_HDL_DIR ?= $(shell dirname $(PWD))/logisim/hdl
TEST_DIR ?= $(shell dirname $(PWD))/tb


VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/base/logisimTickGenerator.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/base/LogisimClockComponent.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/gates/AND_GATE.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/gates/OR_GATE_BUS_5_INPUTS.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/gates/OR_GATE_3_INPUTS.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/gates/OR_GATE.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/gates/OR_GATE_BUS.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/circuit/main.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/toplevel/logisimTopLevelShell.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/plexers/Decoder_8.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/plexers/Multiplexer_bus_2.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/arith/Adder.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/arith/Comparator.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/arith/Subtractor.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/memory/REGISTER_FLIP_FLOP.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/memory/LogisimCounter.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/memory/S_R_FLIPFLOP.v
VERILOG_SOURCES += $(RTL_DIR)/manchester_baby.v

# MODULE refers to the python file containing tests
# TOPLEVEL refers to the top level module in the source file

# test full adder
test_baby:
	$(MAKE) sim MODULE=test_manchester_baby TOPLEVEL=manchester_baby

test_logisim_subtractor:
	$(MAKE) sim MODULE=test_logisim_subtractor TOPLEVEL=tb_logisim_subtractor

# removes everything related to testing
# cleaner:
# $(MAKE) clean
# rm *.vcd
# rm results.xml

include $(shell cocotb-config --makefiles)/Makefile.sim