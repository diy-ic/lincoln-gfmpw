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


def send_instruction(dut, instruction: Instructions, address=0, value=0):
    dut.instruction_i.value = instruction.value
    dut.address_i.value = address
    dut.value_i.value = value

async def send_instruction_and_wait_posedge_clock(dut, instruction: Instructions, address=0, value=0):
    dut.instruction_i.value = instruction.value
    dut.address_i.value = address
    dut.value_i.value = value
    await RisingEdge(dut.clk_i)

@cocotb.test()
async def test_core(dut):
    """
    determine if the module is perfomring the correct arithmetic
    - this is dependent on the user program that was passed into the compiler
    - simple neuron for this example
    """

    # TODO: probably add more test cases, but the fact that the core is returning values at all is a good sign 

    cocotb.start_soon(Clock(dut.clk_i, 1, "ns").start())
    await RisingEdge(dut.clk_i)

    # write zeroes to inputs
    for i in range(4):
        send_instruction(dut, Instructions.WRITE, i, 0)
        await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

    assert dut.uut_ci.uut_simple_neuron.x0.value == 0
    assert dut.uut_ci.uut_simple_neuron.x1.value == 0
    assert dut.uut_ci.uut_simple_neuron.x2.value == 0
    assert dut.uut_ci.uut_simple_neuron.x3.value == 0

    # wait for change in result
    # should be equal to 5 clock cycles
    await Edge(dut.uut_ci.uut_simple_neuron.r)

    # should be able to read the result back
    dut.instruction_i.value = Instructions.READ.value
    dut.address_i.value = 4
    for i in range(5):
        await RisingEdge(dut.clk_i)
    # await Edge(dut.result_o)
    assert dut.result_o == 0


    await send_instruction_and_wait_posedge_clock(dut, Instructions.WRITE, 0, 1)

    send_instruction(dut, Instructions.READ, 4)
    await Edge(dut.result_o)
    assert dut.result_o == 3

    await send_instruction_and_wait_posedge_clock(dut, Instructions.WRITE, 1, 1)
    await send_instruction_and_wait_posedge_clock(dut, Instructions.WRITE, 2, 1)
    await send_instruction_and_wait_posedge_clock(dut, Instructions.WRITE, 3, 1)
    

    send_instruction(dut, Instructions.READ, 4)
    # wait 5 clock cycles after the latest write
    for i in range(5):
        await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)
    assert dut.result_o.value == 4