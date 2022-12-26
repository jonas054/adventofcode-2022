EXAMPLE = <<~TEXT.freeze
  [1,1,3,1,1]
  [1,1,5,1,1]

  [[1],[2,3,4]]
  [[1],4]

  [9]
  [[8,7,6]]

  [[4,4],4,4]
  [[4,4],4,4,4]

  [7,7,7,7]
  [7,7,7]

  []
  [3]

  [[[]]]
  [[]]

  [1,[2,[3,[4,[5,6,7]]]],8,9]
  [1,[2,[3,[4,[5,6,0]]]],8,9]
TEXT

def main(input)
  indexes = input.split("\n\n").map(&:split).each_with_index.map do |(left, right), index|
    compare(eval(left), eval(right)) < 1 ? index + 1 : 0
  end
  p indexes.sum
end

def compare(left, right)
  return left <=> right if left.is_a?(Integer) && right.is_a?(Integer)
  return compare(Array(left), Array(right)) if left.is_a?(Array) ^ right.is_a?(Array)

  left.zip(right).each do |a, b|
    return 1 if b.nil?

    result = compare(a, b)
    return result if result != 0
  end

  right.length > left.length ? -1 : 0
end

if $PROGRAM_NAME == __FILE__
  main(EXAMPLE) # 13
  main(File.read('13.input')) # 6478
end
