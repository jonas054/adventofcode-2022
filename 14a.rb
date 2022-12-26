EXAMPLE = <<~TEXT.freeze
  498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9
TEXT

DIRECTIONS = [0 + 1i, -1 + 1i, 1 + 1i]

def main(input)
  parse(input)
  print "\033[0;0H"
  print "\033[2J"
  @offset = @grid.keys.map(&:real).min - 4
  @grid.each { |key, value| display(key, value) }
  loop do
    sand = 500
    loop do
      display(sand, '+')
      if DIRECTIONS.all? { @grid.key?(sand + _1) }
        @grid[sand] = 'o'
        display(sand, 'o')
        break
      end

      display(sand, ' ')
      sand += Complex(DIRECTIONS.find { !@grid.key?(sand + _1) }.real, 1)
      break if sand.imag > @bottom
    end
    break if sand.imag > @bottom
  end
  print "\033[0;0H"
  puts @grid.values.count('o')
end

def parse(input)
  @grid = {}
  input.lines.each do |line|
    line.scan(/\d+,\d+/)
        .map { _1.split(',').map(&:to_i) }
        .map { Complex(_1, _2) }
        .each_cons(2) { draw_rock(_1, _2) }
  end
  @bottom = @grid.keys.map(&:imag).max
end

def display(key, value)
  print "\033[#{key.imag};#{key.real - @offset}H"
  print value
end

def draw_rock(start, finish)
  if start.real == finish.real
    a, b = [start.imag, finish.imag].sort
    (a..b).each { @grid[Complex(start.real, _1)] = '#' }
  else
    a, b = [start.real, finish.real].sort
    (a..b).each { @grid[Complex(_1, start.imag)] = '#' }
  end
end

if $PROGRAM_NAME == __FILE__
  print "\033[?25l"
  main(EXAMPLE) # 24
  main(File.read('14.input')) # 779
  print "\033[?25h"
end
