import mos6502

import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_decoder(dut):
    
    failed_decode = False
    failed_opcode_list = []

    for mnemonic in mos6502.Instruction:
        opcode, decode_value = mnemonic.value

        if decode_value is None:
            failed_decode = True
            failed_opcode_list.append([mnemonic, None])
            continue
        else:
            dut.instruction_i.value = opcode
            await Timer(1, "ps")

            if dut.decoded_instruction_o.value != decode_value:
                failed_decode = True
                failed_opcode_list.append([mnemonic, dut.decoded_instruction_o.value])
    

    if failed_decode == True:
        print(f"failed to decode:")
        for x in failed_opcode_list:
            mnemonic = x[0].name
            opcode = x[0].value[0]
            expected = x[0].value[1]
            actual = x[1]

        print(f"\t{mnemonic} (0x{hex(opcode)[2:].upper()})\n\t\texpected:\t{bin(expected)[2:]}\n\t\tactual:\t{actual}")

    assert failed_decode == False