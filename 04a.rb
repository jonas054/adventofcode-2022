require 'set'

EXAMPLE = <<~TEXT.freeze
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
TEXT

def main(input)
  input.lines.map(&:chomp).map { _1.split(',') }.count do |pair|
    ranges = pair.map { _1.split('-').map(&:to_i) }.map { Range.new(*_1) }
    overlap?(*ranges.map { Set.new(_1) })
  end
end

def overlap?(a, b) = a.subset?(b) || b.subset?(a)

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 2
  p main(File.read('04.input')) # 571
end
