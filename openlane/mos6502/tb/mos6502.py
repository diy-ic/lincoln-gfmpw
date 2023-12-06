from enum import Enum, IntEnum


class _DecoderNumericValue(IntEnum):
    ADC = 2**0
    AND = 2**1
    ASL = 2**2
    BCC = 2**4
    BCS = 2**5
    BEQ = 2**6
    BMI = 2**7
    BNE = 2**8
    BPL = 2**9
    BRK = 2**10
    BVC = 2**11
    BVS = 2**12
    CLC = 2**13
    CLD = 2**14
    CLI = 2**15
    CLV = 2**16
    CMP = 2**17
    CPX = 2**18
    CPY = 2**19
    DEC = 2**20
    DES = 2**21
    DEY = 2**22
    EOR = 2**23
    INC = 2**24
    INX = 2**25
    INY = 2**26
    JMP = 2**27
    JSR = 2**28
    LDA = 2**29
    LDX = 2**30
    LDX_Y = 2**31,
    LDY = 2**32
    LSR = 2**33
    ORA = 2**34
    PHA = 2**35
    PHP = 2**36
    PLA = 2**37
    PLP = 2**38
    ROL = 2**39
    ROR = 2**40
    RTI = 2**41
    RTS = 2**42
    SBC = 2**43
    SEC = 2**44
    SED = 2**45
    SEI = 2**46
    STA = 2**47
    STX = 2**48
    STY = 2**49
    TAX = 2**50
    TAY = 2**51
    TKA = 2**52
    TKS = 2**53
    TSX = 2**54
    TYA = 2**55


class _Modifiers(IntEnum):
    # modifiers to add onto the expected decoder value
    _A = 2**3
    _X_IND = 2**56
    _ABS_X = 2**57
    _ABS_Y = 2**58
    _ABS = 2**59
    _HASH = 2**60
    _IND_Y = 2**61
    _IND = 2**62
    _REL = 2**63
    _ZPG_X = 2**64
    _ZPG = 2**65

class Instruction(Enum):
    

    # instructions & opcodes from https://www.masswerk.at/6502/6502_instruction_set.html
    # format is: MNEMONIC: [OPCODE, EXPECTED_DECODE_VALUE]
    # EXPECTED_DECODE_VALUE is based on its position in decoded_instruction_o in mos6502_decoder.v
    BRK =       [0x00, _DecoderNumericValue.BRK.value]
    ORA_X_IND = [0x01, _DecoderNumericValue.ORA + _Modifiers._X_IND]
    ORA_ZPG =   [0x05, _DecoderNumericValue.ORA + _Modifiers._ZPG]
    ASL_ZPG =   [0x06, _DecoderNumericValue.ASL + _Modifiers._ZPG]
    PHP =       [0x08, _DecoderNumericValue.PHP.value]
    ORA_HASH =  [0x09, _DecoderNumericValue.ORA + _Modifiers._HASH]
    ASL_A =     [0x0A, _DecoderNumericValue.ASL + _Modifiers._A]
    ORA_ABS =   [0x0D, _DecoderNumericValue.ORA + _Modifiers._ABS]
    ASL_ABS =   [0x0E, _DecoderNumericValue.ASL + _Modifiers._ABS]

    BPL_REL =   [0x10, _DecoderNumericValue.BPL + _Modifiers._REL]
    ORA_IND_Y = [0x11, _DecoderNumericValue.ORA + _Modifiers._IND_Y]
    ORA_ZPG_X = [0x15, _DecoderNumericValue.ORA + _Modifiers._ZPG_X]
    ASL_ZPG_X = [0x16, _DecoderNumericValue.ASL + _Modifiers._ZPG_X]
    CLC =       [0x18, _DecoderNumericValue.CLC.value]
    ORA_ABS_Y = [0x19, _DecoderNumericValue.ORA + _Modifiers._ABS_Y]
    ORA_ABS_X = [0x1D, _DecoderNumericValue.ORA + _Modifiers._ABS_X]
    ASL_ABS_X = [0x1E, _DecoderNumericValue.ASL + _Modifiers._ABS_X]

    JSR_ABS =   [0x20, _DecoderNumericValue.JSR + _Modifiers._ABS]
    AND_X_IND = [0x21, _DecoderNumericValue.AND + _Modifiers._X_IND]
    BIT_ZPG =   [0x24, None] # not implemented in logisim
    AND_ZPG =   [0x25, _DecoderNumericValue.AND + _Modifiers._ZPG]
    ROL_ZPG =   [0x26, _DecoderNumericValue.ROL + _Modifiers._ZPG]
    PLP =       [0x28, _DecoderNumericValue.PLP.value]
    AND_HASH =  [0x29, _DecoderNumericValue.AND + _Modifiers._HASH]
    ROL_A =     [0x2A, _DecoderNumericValue.ROL + _Modifiers._A]
    BIT_ABS =   [0x2C, None] # not implemented in logisim
    AND_ABS =   [0x2D, _DecoderNumericValue.AND + _Modifiers._ABS]
    ROL_ABS =   [0x2E, _DecoderNumericValue.ROL + _Modifiers._ABS]

    BMI_REL =   [0x30, _DecoderNumericValue.BMI + _Modifiers._REL]
    AND_IND_Y = [0x31, _DecoderNumericValue.AND + _Modifiers._IND_Y]
    AND_ZPG_X = [0x35, _DecoderNumericValue.AND + _Modifiers._ZPG]
    ROL_ZPG_X = [0x36, _DecoderNumericValue.ROL + _Modifiers._ZPG_X]
    SEC =       [0x38, _DecoderNumericValue.SEC.value]
    AND_ABS_Y = [0x39, _DecoderNumericValue.AND + _Modifiers._ABS_Y]
    AND_ABS_X = [0x3D, _DecoderNumericValue.AND + _Modifiers._ABS_X]
    ROL_ABS_X = [0x3E, _DecoderNumericValue.ROL + _Modifiers._ABS_X]

    RTI =       [0x40, _DecoderNumericValue.RTI.value]
    EOR_X_IND = [0x41, _DecoderNumericValue.EOR + _Modifiers._X_IND]
    EOR_ZPG =   [0x45, _DecoderNumericValue.EOR + _Modifiers._ZPG]
    LSR_ZPG =   [0x46, _DecoderNumericValue.LSR + _Modifiers._ZPG]
    PHA =       [0x48, _DecoderNumericValue.PHA.value]
    EOR_HASH =  [0x49, _DecoderNumericValue.EOR + _Modifiers._HASH]
    LSR_A =     [0x4A, _DecoderNumericValue.LSR + _Modifiers._A]
    JMP_ABS =   [0x4C, _DecoderNumericValue.JMP + _Modifiers._ABS]
    EOR_ABS =   [0x4D, _DecoderNumericValue.EOR + _Modifiers._ABS]
    LSR_ABS =   [0x4E, _DecoderNumericValue.LSR + _Modifiers._ABS]
    
    BVC_REL = [0x50, _DecoderNumericValue.BVC + _Modifiers._REL]
    EOR_IND_Y = [0x51, _DecoderNumericValue.EOR + _Modifiers._IND_Y]
    EOR_ZPG_X = [0x55, _DecoderNumericValue.EOR + _Modifiers._ZPG_X]
    LSR_ZPG_X = [0x56, _DecoderNumericValue.LSR + _Modifiers._ZPG_X]
    CLI = [0x58, _DecoderNumericValue.CLI.value]
    EOR_ABS_Y = [0x59, _DecoderNumericValue.EOR + _Modifiers._ABS_Y]
    EOR_ABS_X = [0x5D, _DecoderNumericValue.EOR + _Modifiers._ABS_X]
    LSR_ABS_X = [0x5E, _DecoderNumericValue.LSR + _Modifiers._ABS_X]

    RTS = [0x60, _DecoderNumericValue.RTS.value]
    ADC_X_IND = [0x61, _DecoderNumericValue.ADC + _Modifiers._X_IND]
    ADC_ZPG = [0x65, _DecoderNumericValue.ADC + _Modifiers._ZPG]
    ROR_ZPG = [0x66, _DecoderNumericValue.ROR + _Modifiers._ZPG]
    PLA = [0x68, _DecoderNumericValue.PLA.value]
    ADC_HASH = [0x69, _DecoderNumericValue.ADC + _Modifiers._HASH]
    ROR_A = [0x6A, _DecoderNumericValue.ROR + _Modifiers._A]
    JMP_IND = [0x6C, _DecoderNumericValue.JMP + _Modifiers._IND]
    ADC_ABS = [0x6D, _DecoderNumericValue.ADC + _Modifiers._ABS]
    ROR_ABS = [0x6E, _DecoderNumericValue.ROR + _Modifiers._ABS]

    BVS_REL = [0x70, _DecoderNumericValue.BVS + _Modifiers._REL]
    ADC_IND_Y = [0x71, _DecoderNumericValue.ADC + _Modifiers._IND_Y]
    ADC_ZPG_X = [0x75, _DecoderNumericValue.ADC + _Modifiers._ZPG_X]
    ROR_ZPG_X = [0x76, _DecoderNumericValue.ROR + _Modifiers._ZPG_X]
    SEI = [0x78, _DecoderNumericValue.SEI.value]
    ADC_ABS_Y = [0x79, _DecoderNumericValue.ADC + _Modifiers._ABS_Y]
    ADC_ABS_X = [0x7D, _DecoderNumericValue.ADC + _Modifiers._ABS_X]
    ROR_ABS_X = [0x7E, _DecoderNumericValue.ROR + _Modifiers._ABS_X]

    STA_X_IND = [0x81, _DecoderNumericValue.STA + _Modifiers._X_IND]
    STY_ZPG = [0x84, _DecoderNumericValue.STY + _Modifiers._ZPG]
    STA_ZPG = [0x85, _DecoderNumericValue.STA + _Modifiers._ZPG]
    STX_ZPG = [0x86, _DecoderNumericValue.STX + _Modifiers._ZPG]
    DEY = [0x88, _DecoderNumericValue.DEY.value]
    TXA = [0x8A, _DecoderNumericValue.TKA.value] # TXS -> TKA in logisim
    STY_ABS = [0x8C, _DecoderNumericValue.STY + _Modifiers._ABS]
    STA_ABS = [0x8D, _DecoderNumericValue.STA + _Modifiers._ABS]
    STX_ABS = [0x8E, _DecoderNumericValue.STX + _Modifiers._ABS]

    BCC_REL = [0x90, _DecoderNumericValue.BCC + _Modifiers._REL]
    STA_IND_Y = [0x91, _DecoderNumericValue.STA + _Modifiers._IND_Y]
    STY_ZPG_X = [0x94, _DecoderNumericValue.STY + _Modifiers._ZPG_X]
    STA_ZPG_X = [0x95, _DecoderNumericValue.STA + _Modifiers._ZPG_X]
    STX_ZPG_Y = [0x96, None] # _ZPG_Y not implemented in logisim
    TYA = [0x98, _DecoderNumericValue.TYA.value]
    STA_ABS_Y = [0x99, _DecoderNumericValue.STA + _Modifiers._ABS_Y]
    TXS = [0x9A, _DecoderNumericValue.TKS.value] # TXS -> TKA in logisim
    STA_ABS_X = [0x9D, _DecoderNumericValue.STA + _Modifiers._ABS_X]

    LDY_HASH = [0xA0, _DecoderNumericValue.LDA + _Modifiers._HASH]
    LDA_X_IND = [0xA1, _DecoderNumericValue.LDA + _Modifiers._X_IND]
    LDX_HASH = [0xA2, _DecoderNumericValue.LDX + _Modifiers._HASH]
    LDY_ZPG = [0xA4, _DecoderNumericValue.LDY + _Modifiers._ZPG]
    LDA_ZPG = [0xA5, _DecoderNumericValue.LDA + _Modifiers._ZPG]
    LDX_ZPG = [0xA6, _DecoderNumericValue.LDX + _Modifiers._ZPG]
    TAY = [0xA8, _DecoderNumericValue.TAY.value]
    LDA_HASH  = [0xA9, _DecoderNumericValue.LDA + _Modifiers._HASH]
    TAX = [0xAA, _DecoderNumericValue.TAX.value]
    LDY_ABS = [0xAC, _DecoderNumericValue.LDY + _Modifiers._ABS]
    LDA_ABS = [0xAD, _DecoderNumericValue.LDA + _Modifiers._ABS]
    LDX_ABS = [0xAE, _DecoderNumericValue.LDX + _Modifiers._ABS]

    BCS_REL = [0xB0, _DecoderNumericValue.BCS + _Modifiers._REL]
    LDA_IND_Y = [0xB1, _DecoderNumericValue.LDA + _Modifiers._IND_Y]
    LDY_ZPG_X = [0xB4, _DecoderNumericValue.LDY + _Modifiers._ZPG_X]
    LDA_ZPG_X = [0xB5, _DecoderNumericValue.LDA + _Modifiers._ZPG_X]
    LDX_ZPG_Y = [0xB6, None] # _ZPG_Y not implemented in logisim
    CLV = [0xB8, _DecoderNumericValue.CLV.value]
    LDA_ABS_Y = [0xB9, _DecoderNumericValue.LDA + _Modifiers._ABS_Y]
    TSX = [0xBA, _DecoderNumericValue.TSX.value]
    LDY_ABS_X = [0xBC, _DecoderNumericValue.LDY + _Modifiers._ABS_X]
    LDA_ABS_X = [0xBD, _DecoderNumericValue.LDA + _Modifiers._ABS_X]
    LDX_ABS_Y = [0xBE, _DecoderNumericValue.LDA + _Modifiers._ABS_Y]

    CPY_HASH = [0xC0, _DecoderNumericValue.CPY + _Modifiers._HASH]
    CMP_X_IND = [0xC1, _DecoderNumericValue.CMP + _Modifiers._X_IND]
    CPY_ZPG = [0xC4, _DecoderNumericValue.CPY + _Modifiers._ZPG]
    CMP_ZPG = [0xC5, _DecoderNumericValue.CMP + _Modifiers._ZPG]
    DEC_ZPG = [0xC6, _DecoderNumericValue.DEC + _Modifiers._ZPG]
    INY = [0xC8, _DecoderNumericValue.INY.value]
    CMP_HASH = [0xC9, _DecoderNumericValue.CMP + _Modifiers._HASH]
    DEX = [0xCA, _DecoderNumericValue.DES] # DEX -> DES in logisim
    CPY_ABS = [0xCC, _DecoderNumericValue.CPY + _Modifiers._ABS]
    CMP_ABS = [0xCD, _DecoderNumericValue.CMP + _Modifiers._ABS]
    DEC_ABS = [0xCE, _DecoderNumericValue.DEC + _Modifiers._ABS]

    BNE_REL = [0xD0, _DecoderNumericValue.BNE + _Modifiers._REL]
    CMP_IND_Y = [0xD1, _DecoderNumericValue.CMP + _Modifiers._IND_Y]
    CMP_ZPG_X = [0xD5, _DecoderNumericValue.CMP + _Modifiers._ZPG_X]
    DEC_ZPG_X = [0xD6, _DecoderNumericValue.DEC + _Modifiers._ZPG_X]
    CLD = [0xD8, _DecoderNumericValue.CLD.value]
    CMP_ABS_Y = [0xD9, _DecoderNumericValue.CMP + _Modifiers._ABS_Y]
    CMP_ABS_X = [0xDD, _DecoderNumericValue.CMP + _Modifiers._ABS_X]
    DEC_ABS_X = [0xDE, _DecoderNumericValue.DEC + _Modifiers._ABS_X]

    CPX_HASH = [0xE0, _DecoderNumericValue.CPX + _Modifiers._HASH]
    SBC_X_IND = [0xE1, _DecoderNumericValue.SBC + _Modifiers._X_IND]
    CPX_ZPG = [0xE4, _DecoderNumericValue.CPX + _Modifiers._ZPG]
    SBC_ZPG = [0xE5, _DecoderNumericValue.SBC + _Modifiers._ZPG]
    INC_ZPG = [0xE6, _DecoderNumericValue.INC + _Modifiers._ZPG]
    INX = [0xE8, _DecoderNumericValue.INX.value]
    SBC_HASH = [0xE9, _DecoderNumericValue.SBC + _Modifiers._HASH]
    NOP = [0xEA, None] # not implemented in logisim
    CPX_ABS = [0xEC, _DecoderNumericValue.CPX + _Modifiers._ABS]
    SBC_ABS = [0xED, _DecoderNumericValue.SBC + _Modifiers._ABS]
    INC_ABS = [0xEE, _DecoderNumericValue.INC + _Modifiers._ABS]

    BEQ_REL = [0xF0, _DecoderNumericValue.BEQ + _Modifiers._REL]
    SBC_IND_Y = [0xF1, _DecoderNumericValue.SBC + _Modifiers._IND_Y]
    SBC_ZPG_X = [0xF5, _DecoderNumericValue.SBC + _Modifiers._ZPG_X]
    INC_ZPG_X = [0xF6, _DecoderNumericValue.INC + _Modifiers._ZPG_X]
    SED = [0xF8, _DecoderNumericValue.SED.value]
    SBC_ABS_Y = [0xF9, _DecoderNumericValue.SBC + _Modifiers._ABS_Y]
    SBC_ABS_X = [0xFD, _DecoderNumericValue.SBC + _Modifiers._ABS_X]
    INC_ABS_X = [0xFE, _DecoderNumericValue.INC + _Modifiers._ABS_X]