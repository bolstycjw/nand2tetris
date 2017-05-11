class SymbolTable
  def initialize
    @symbol_table = {
      'SP' => 0,
      'LCL' => 1,
      'ARG' => 2,
      'THIS' => 3,
      'THAT' => 4,
      'SCREEN' => 16_384,
      'KBD' => 24_576
    }
    (0..15).each do |n|
      @symbol_table["R#{n}"] = n
    end
  end

  def add_entry(symbol, address)
    @symbol_table[symbol] = address
  end

  def contains?(symbol)
    @symbol_table.key? symbol
  end

  def get_address(symbol)
    @symbol_table[symbol]
  end
end
