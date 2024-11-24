enum KeyCode {
  kVkSpace(0x31, ' '),
  kVkAnsiA(0x00, 'A'),
  kVkAnsiS(0x01, 'S'),
  kVkAnsiD(0x02, 'D'),
  kVkAnsiF(0x03, 'F'),
  kVkAnsiH(0x04, 'H'),
  kVkAnsiG(0x05, 'G'),
  kVkAnsiZ(0x06, 'Z'),
  kVkAnsiX(0x07, 'X'),
  kVkAnsiC(0x08, 'C'),
  kVkAnsiV(0x09, 'V'),
  kVkAnsiB(0x0B, 'B'),
  kVkAnsiQ(0x0C, 'Q'),
  kVkAnsiW(0x0D, 'W'),
  kVkAnsiE(0x0E, 'E'),
  kVkAnsiR(0x0F, 'R'),
  kVkAnsiY(0x10, 'Y'),
  kVkAnsiT(0x11, 'T'),
  kVkAnsi1(0x12, '1'),
  kVkAnsi2(0x13, '2'),
  kVkAnsi3(0x14, '3'),
  kVkAnsi4(0x15, '4'),
  kVkAnsi6(0x16, '6'),
  kVkAnsi5(0x17, '5'),
  kVkAnsiEqual(0x18, '='),
  kVkAnsi9(0x19, '9'),
  kVkAnsi7(0x1A, '7'),
  kVkAnsiMinus(0x1B, '-'),
  kVkAnsi8(0x1C, '8'),
  kVkAnsi0(0x1D, '0'),
  kVkAnsiRightBracket(0x1E, ']'),
  kVkAnsiO(0x1F, 'O'),
  kVkAnsiU(0x20, 'U'),
  kVkAnsiLeftBracket(0x21, '['),
  kVkAnsiI(0x22, 'I'),
  kVkAnsiP(0x23, 'P'),
  kVkAnsiL(0x25, 'L'),
  kVkAnsiJ(0x26, 'J'),
  kVkAnsiQuote(0x27, '\''),
  kVkAnsiK(0x28, 'K'),
  kVkAnsiSemicolon(0x29, ';'),
  kVkAnsiBackslash(0x2A, '\\'),
  kVkAnsiComma(0x2B, ','),
  kVkAnsiSlash(0x2C, '/'),
  kVkAnsiN(0x2D, 'N'),
  kVkAnsiM(0x2E, 'M'),
  kVkAnsiPeriod(0x2F, '.'),
  kVkAnsiGrave(0x32, '`'),
  kVkAnsiKeypadDecimal(0x41, '.'),
  kVkAnsiKeypadMultiply(0x43, '*'),
  kVkAnsiKeypadPlus(0x45, '+'),
  kVkAnsiKeypadClear(0x47, 'C'),
  kVkAnsiKeypadDivide(0x4B, '/'),
  kVkAnsiKeypadEnter(0x4C, 'E'),
  kVkAnsiKeypadMinus(0x4E, '-'),
  kVkAnsiKeypadEquals(0x51, '='),
  kVkAnsiKeypad0(0x52, '0'),
  kVkAnsiKeypad1(0x53, '1'),
  kVkAnsiKeypad2(0x54, '2'),
  kVkAnsiKeypad3(0x55, '3'),
  kVkAnsiKeypad4(0x56, '4'),
  kVkAnsiKeypad5(0x57, '5'),
  kVkAnsiKeypad6(0x58, '6'),
  kVkAnsiKeypad7(0x59, '7'),
  kVkAnsiKeypad8(0x5B, '8'),
  kVkAnsiKeypad9(0x5C, '9');

  final int code;
  final String char;

  const KeyCode(this.code, this.char);

  static KeyCode? fromChar(String char) {
    for (var key in KeyCode.values) {
      if (key.char.toLowerCase() == char.toLowerCase()) {
        return key;
      }
    }
    return null;
  }
}
