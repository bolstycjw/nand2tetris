require_relative 'constants'

class CodeWriter
  def initialize(file)
    @out = file
    @call_count = 0
    @eq_count = 0
    @gt_count = 0
    @lt_count = 0
    @function_name = ''
  end

  def comment(string)
    @out.puts string
  end

  def set_filename(filename)
    @filename = filename
  end

  def write_init
    @out.puts INIT
    write_call('Sys.init', 0)
    @out.puts '0;JMP'
  end

  def write_call(function_name, num_args)
    @out.puts <<~ASM
      // CALL #{function_name}
      @RETURN.#{@call_count}
      D=A
      #{PUSH}
      @LCL
      D=M
      #{PUSH}
      @ARG
      D=M
      #{PUSH}
      @THIS
      D=M
      #{PUSH}
      @THAT
      D=M
      #{PUSH}
      @#{num_args + 5}
      D=A
      @SP
      D=M-D
      @ARG
      M=D
      @SP
      D=M
      @LCL
      M=D
      @#{function_name}
      0;JMP
      (RETURN.#{@call_count})
    ASM
    @call_count += 1
  end

  def write_function(function_name, num_locals)
    @function_name = function_name
    @out.puts <<~ASM
      (#{function_name})
      @SP
      A=M
    ASM
    num_locals.times do
      @out.puts <<~ASM
        M=0
        A=A+1
      ASM
    end
    @out.puts <<~ASM
      D=A
      @SP
      M=D
    ASM
  end

  def write_return
    @out.puts RETURN
  end

  def write_label(label)
    @out.puts "(#{@function_name}$#{label})"
  end

  def write_goto(label)
    @out.puts <<~ASM
      @#{@function_name}$#{label}
      0;JMP
    ASM
  end

  def write_if(label)
    @out.puts <<~ASM
      @SP
      AM=M-1
      D=M
      @#{@function_name}$#{label}
      D;JNE
    ASM
  end

  def write_arithmetic(command)
    @out.puts '@SP'
    case command
    when 'add'
      @out.puts ADD
    when 'sub'
      @out.puts SUB
    when 'neg'
      @out.puts NEG
    when 'and'
      @out.puts AND
    when 'or'
      @out.puts OR
    when 'not'
      @out.puts NOT
    when 'eq'
      @out.puts <<~ASM
        AM=M-1
        D=M
        A=A-1
        D=M-D
        @EQ.true.#{@eq_count}
        D;JEQ
        @SP
        A=M-1
        M=0
        @EQ.end.#{@eq_count}
        0;JMP
        (EQ.true.#{@eq_count})
        @SP
        A=M-1
        M=-1
        (EQ.end.#{@eq_count})
      ASM
      @eq_count += 1
    when 'gt'
      @out.puts <<~ASM
        AM=M-1
        D=M
        A=A-1
        D=M-D
        @GT.true.#{@gt_count}
        D;JGT
        @SP
        A=M-1
        M=0
        @GT.end.#{@gt_count}
        0;JMP
        (GT.true.#{@gt_count})
        @SP
        A=M-1
        M=-1
        (GT.end.#{@gt_count})
      ASM
      @gt_count += 1
    when 'lt'
      @out.puts <<~ASM
        AM=M-1
        D=M
        A=A-1
        D=M-D
        @LT.true.#{@lt_count}
        D;JLT
        @SP
        A=M-1
        M=0
        @LT.end.#{@lt_count}
        0;JMP
        (LT.true.#{@lt_count})
        @SP
        A=M-1
        M=-1
        (LT.end.#{@lt_count})
      ASM
      @lt_count += 1
    end
  end

  def write_push_pop(command, segment, index)
    case command
    when C_POP
      case segment
      when 'static'
        @out.puts <<~ASM
          @#{@filename}.#{index}
          D=A
        ASM
      when 'temp', 'pointer'
        @out.puts <<~ASM
          @#{index}
          D=A
          @#{SEGMENTS[segment]}
          D=D+A
        ASM
      else
        @out.puts <<~ASM
          @#{index}
          D=A
          @#{SEGMENTS[segment]}
          D=D+M
        ASM
      end
      @out.puts POP
    when C_PUSH
      case segment
      when 'static'
        @out.puts <<~ASM
          @#{@filename}.#{index}
          D=M
        ASM
      when 'constant'
        @out.puts <<~ASM
          @#{index}
          D=A
        ASM
      when 'temp', 'pointer'
        @out.puts <<~ASM
          @#{index}
          D=A
          @#{SEGMENTS[segment]}
          A=D+A
          D=M
        ASM
      else
        @out.puts <<~ASM
          @#{index}
          D=A
          @#{SEGMENTS[segment]}
          A=D+M
          D=M
        ASM
      end
      @out.puts PUSH
    end
  end

  def close
    @out.close
  end
end
