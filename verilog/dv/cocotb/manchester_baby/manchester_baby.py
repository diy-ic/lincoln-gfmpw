from caravel_cocotb.caravel_interfaces import test_configure
from caravel_cocotb.caravel_interfaces import report_test
from caravel_cocotb.caravel_interfaces import UART
from caravel_cocotb.caravel_interfaces import SPI
import cocotb

@cocotb.test() # decorator to mark the test function as cocotb test
@report_test # wrapper for configure test reporting files
async def test_halt(dut):
    caravelEnv = await test_configure(dut) #configure, start up and reset Caravel
    
    ######################## add test sequence ###################### 

    print(dir(dut))
    assert 1 == 1