def numeric?(string)
  Float(string) != nil rescue false
end

def to_binary(num)
  num = num.to_i
  bin = []
  15.downto(0) do |n|
    bin << num[n]
  end
  bin.join
end
