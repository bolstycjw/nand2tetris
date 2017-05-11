require 'byebug'
require_relative 'parser'
require_relative 'code_writer'
require_relative 'constants'

source_path = ARGV[0]
dir_name = File.basename(source_path)
output_file = File.join(source_path, "#{dir_name}.asm")

code_writer = CodeWriter.new(File.open(output_file, 'w'))
source_path = File.join(source_path, '*.vm') unless source_path.include? '*.vm'
Dir.glob(source_path) do |vm_file|
  parser = Parser.new(vm_file)
  filename = File.basename(vm_file, '.vm')
  code_writer.set_filename(filename)

  while parser.more_commands?
    parser.advance
    code_writer.comment("//#{parser.current}")
    case parser.command_type
    when C_ARITHMETIC
      code_writer.write_arithmetic(parser.arg1)
    when C_PUSH, C_POP
      code_writer.write_push_pop(parser.command_type, parser.arg1, parser.arg2)
    end
  end
end

code_writer.close
