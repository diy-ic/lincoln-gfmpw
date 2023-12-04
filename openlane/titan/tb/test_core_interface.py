import cocotb
from cocotb.triggers import Timer, Edge, RisingEdge, First, Combine
from cocotb.clock import Clock

import random

from instructions import Instructions

# parameters when creating the core interface (see tb_core_interface.v)
START_ADDRESS = 0
END_ADDRESS = 4
TOTAL_INPUTS = 4
TOTAL_OUTPUTS = 1

@cocotb.test()
async def interface_enable_on_address(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, units="ns").start())

    # reset
    dut.instruction_i.value = 0
    dut.address_i.value = 0
    dut.value_i.value = 0
    await RisingEdge(dut.clk_i)

    dut.address_i.value = 0xFFFFFF
    await RisingEdge(dut.clk_i)

    assert dut.uut_ci.interface_enable.value == 0

    for i in range(START_ADDRESS, END_ADDRESS+2):
        dut.address_i.value = i
        await RisingEdge(dut.clk_i)
        print(f"{i} {(i>= START_ADDRESS and i<= END_ADDRESS)}")
        assert dut.uut_ci.interface_enable.value == (i >= START_ADDRESS and i <= END_ADDRESS)



@cocotb.test()
async def instruction_read_write(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, units="ns").start())

    written_value = None
    for run in range(5):

        for address in range(4):

            dut.instruction_i.value = Instructions.WRITE.value
            dut.address_i.value = address

            written_value = random.randint(0, 2**32)
            dut.value_i.value = written_value

            # cocotb.RisingEdge would trigger at the very beginning of the testbench
            # but if we were doing an assertion then it would fail
            await Timer(2, "ns") if run == 0 else await Timer(1, "ns")

            assert dut.uut_ci.input_memory[address] == written_value

            dut.instruction_i.value = Instructions.READ.value
            await Timer(1, "ns")

            assert dut.result_o.value == written_value



@cocotb.test()
async def instruction_bind_read_address(dut):
    """
    tests BIND_READ_ADDRESS instruction - sets "stream_enabled" flag when an output address is targeted
    """

    cocotb.start_soon(Clock(dut.clk_i, 1, units="ns").start())

    for offset in range(2):
        dut.instruction_i.value = Instructions.BIND_READ_ADDRESS.value
        dut.address_i.value = 4 if offset == 0 else 2**24 - 1

        await Timer(2, "ns")

        if offset == 0:
            assert dut.uut_ci.stream_enabled == 1
        elif offset == 1:
            assert dut.uut_ci.stream_enabled == 0


@cocotb.test()
async def instruction_bind_write_address(dut):
    """
    tests BIND_WRITE_ADDRESS instruction - sets "stream enabled" flag when an input address is targeted
    """
    
    cocotb.start_soon(Clock(dut.clk_i, 1, "ns").start())

    for address in range(2):
        dut.instruction_i.value = Instructions.BIND_WRITE_ADDRESS.value
        dut.address_i.value = address
        await Timer(2, "ns")

        assert dut.uut_ci.stream_enabled == 1

        # change address to index something out of range
        dut.address_i.value = 2**24 - 1
        await Timer(2, "ns")

        assert dut.uut_ci.stream_enabled == 0