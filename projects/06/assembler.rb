require 'byebug'
require_relative 'parser'
require_relative 'code'
require_relative 'helpers'
require_relative 'symbol_table'

path = ARGV[0]
code = Code.new
symbol_table = SymbolTable.new

first_pass = Parser.new(path)
rom_address = 0
while first_pass.more_commands?
  first_pass.advance
  if first_pass.command_type == Parser::L_COMMAND
    symbol_table.add_entry(first_pass.symbol, rom_address)
  else
    rom_address += 1
  end
end

second_pass = Parser.new(path)
ram_address = 16
hack_commands = []
while second_pass.more_commands?
  second_pass.advance
  case second_pass.command_type
  when Parser::A_COMMAND
    symbol = second_pass.symbol
    if numeric? symbol
      hack_commands << to_binary(symbol)
    else
      if symbol_table.contains?(symbol)
        hack_commands << to_binary(symbol_table.get_address(symbol))
      else
        symbol_table.add_entry(symbol, ram_address)
        hack_commands << to_binary(ram_address)
        ram_address += 1
      end
    end
  when Parser::C_COMMAND
    comp = code.comp(second_pass.comp)
    dest = code.dest(second_pass.dest)
    jump = code.jump(second_pass.jump)
    hack_command = "111#{comp + dest + jump}"
    hack_commands << hack_command
  end
end
output = hack_commands.join("\n")
output_path = "#{path.split('.asm')[0]}.hack"
File.open(output_path, 'w') do |f|
  f.write(output)
end
