EXAMPLE = <<~TEXT.freeze
  R 5
  U 8
  L 8
  D 3
  R 17
  D 10
  L 25
  U 20
TEXT

DIRECTIONS = { 'U' => 0 - 1i, 'D' => 0 + 1i, 'L' => -1, 'R' => 1 }

def main(input)
  @knots = [0] * 10
  @visited = { 0 => true }
  input.lines.each do |line|
    line =~ /([A-Z]) (\d+)/
    $2.to_i.times do
      @knots[0] += DIRECTIONS[$1]
      @knots.each_index { |ix| move(ix) if ix > 0 && !touching?(ix) }
      @visited[@knots.last] = true
    end
  end
  @visited.size
end

def touching?(ix) = delta(ix).real.abs < 2 && delta(ix).imag.abs < 2

def move(ix) = @knots[ix] += Complex(max_one(delta(ix).real), max_one(delta(ix).imag))

def delta(ix) = @knots[ix - 1] - @knots[ix]

def max_one(n) = n == 0 ? 0 : n / n.abs

p main(EXAMPLE) # 36
p main(File.read('09.input')) # 2485
