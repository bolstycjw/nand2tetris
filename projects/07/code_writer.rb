require_relative 'constants'

class CodeWriter
  def initialize(file)
    @out = file
    @eq_count = 0
    @gt_count = 0
    @lt_count = 0
  end

  def comment(string)
    @out.puts string
  end

  def set_filename(filename)
    @filename = filename
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
