require 'set'

EXAMPLE = <<~TEXT.freeze
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
TEXT

DIRECTIONS = { 'U' => 0 - 1i, 'D' => 0 + 1i, 'L' => -1, 'R' => 1 }

def main(input)
  @head = @tail = 0
  @visited = Set.new([0])
  input.lines.each do |line|
    line =~ /([A-Z]) (\d+)/
    $2.to_i.times { move(DIRECTIONS[$1]) }
  end
  @visited.size
end

def move(movement)
  @head += movement
  return if touching?

  @tail += Complex(max_one(delta.real), max_one(delta.imag))
  @visited << @tail
end

def touching? = delta.real.abs < 2 && delta.imag.abs < 2

def delta = @head - @tail

def max_one(n) = n == 0 ? 0 : n / n.abs

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 13
  p main(File.read('09.input')) # 6037
end
