require_relative 'constants'

class Parser
  def initialize(path)
    @file = File.new(path, 'r')
  end

  def current
    @cur_command
  end

  def more_commands?
    !@file.eof?
  end

  def advance
    loop do
      @cur_command = @file.readline.gsub(%r{//[\s\S]*}, '').strip
      break unless @cur_command.empty?
    end
  end

  def command_type
    case @cur_command.split(' ')[0]
    when 'push'
      C_PUSH
    when 'pop'
      C_POP
    when 'label'
      C_LABEL
    when 'goto'
      C_GOTO
    when 'if-goto'
      C_IF
    when 'function'
      C_FUNCTION
    when 'return'
      C_RETURN
    when 'call'
      C_CALL
    else
      C_ARITHMETIC
    end
  end

  def arg1
    if command_type == C_ARITHMETIC
      @cur_command.split(' ')[0]
    else
      @cur_command.split(' ')[1]
    end
  end

  def arg2
    @cur_command.split(' ')[2]
  end
end
