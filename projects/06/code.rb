class Code
  COMP = {
    '0' => '0101010',
    '1' => '0111111',
    '-1' => '0111010',
    'D' => '0001100',
    'A' => '0110000',
    'M' => '1110000',
    '!D' => '0101101',
    '!A' => '0110001',
    '!M' => '1110001',
    '-D' => '0001111',
    '-A' => '0110011',
    '-M' => '1110011',
    'D+1' => '0011111',
    'A+1' => '0110111',
    'M+1' => '1110111',
    'D-1' => '0001110',
    'A-1' => '0110010',
    'M-1' => '1110010',
    'D+A' => '0000010',
    'D+M' => '1000010',
    'D-A' => '0010011',
    'D-M' => '1010011',
    'A-D' => '0000111',
    'M-D' => '1000111',
    'D&A' => '0000000',
    'D&M' => '1000000',
    'D|A' => '0010101',
    'D|M' => '1010101'
  }.freeze
  JUMP = {
    'null' => '000',
    'JGT' => '001',
    'JEQ' => '010',
    'JGE' => '011',
    'JLT' => '000',
    'JNE' => '101',
    'JLE' => '110',
    'JMP' => '111'
  }.freeze

  def dest(mnemonic)
    binary = %w[0 0 0]
    binary[2] = '1' if mnemonic.include? 'M'
    binary[1] = '1' if mnemonic.include? 'D'
    binary[0] = '1' if mnemonic.include? 'A'
    binary.join
  end

  def comp(mnemonic)
    COMP[mnemonic]
  end

  def jump(mnemonic)
    JUMP[mnemonic]
  end
end
