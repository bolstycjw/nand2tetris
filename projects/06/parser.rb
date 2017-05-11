class Parser
  A_COMMAND = 0
  C_COMMAND = 1
  L_COMMAND = 2

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
    if @cur_command[0] == '@'
      A_COMMAND
    elsif @cur_command[0] == '('
      L_COMMAND
    else
      C_COMMAND
    end
  end

  def symbol
    if command_type == A_COMMAND
      @cur_command[1..-1]
    else
      @cur_command[1..-2]
    end
  end

  def dest
    if @cur_command.include? '='
      @cur_command.split('=')[0]
    else
      'null'
    end
  end

  def comp
    if @cur_command.include? '='
      @cur_command.split('=')[1]
    else
      @cur_command.split(';')[0]
    end
  end

  def jump
    if @cur_command.include? ';'
      @cur_command.split(';')[1]
    else
      'null'
    end
  end
end
