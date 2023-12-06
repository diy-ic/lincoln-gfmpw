SIM ?= icarus
TOPLEVEL_LANG ?= verilog

RTL_DIR ?= $(shell dirname $(PWD))/src
LOGISIM_HDL_DIR ?= $(shell dirname $(PWD))/logisim/hdl
TEST_DIR ?= $(shell dirname $(PWD))/tb

VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/gates/AND_GATE.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/gates/OR_GATE.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/plexers/Decoder_16.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/circuit/main.v
VERILOG_SOURCES += $(LOGISIM_HDL_DIR)/toplevel/logisimTopLevelShell.v
VERILOG_SOURCES += $(RTL_DIR)/mos6502_decoder.v

VERILOG_SOURCES += $(TEST_DIR)/tb_decoder.v

# MODULE refers to python file containing tests
# TOPLEVEL refers to the top level module in the source file

test-decode:
	$(MAKE) sim MODULE=test_decoder TOPLEVEL=tb_decoder

include $(shell cocotb-config --makefiles)/Makefile.sim
