SMALL_EXAMPLE = <<~TEXT.freeze
  noop
  addx 3
  addx -5
TEXT

EXAMPLE = <<~TEXT.freeze
  addx 15
  addx -11
  addx 6
  addx -3
  addx 5
  addx -1
  addx -8
  addx 13
  addx 4
  noop
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx -35
  addx 1
  addx 24
  addx -19
  addx 1
  addx 16
  addx -11
  noop
  noop
  addx 21
  addx -15
  noop
  noop
  addx -3
  addx 9
  addx 1
  addx -3
  addx 8
  addx 1
  addx 5
  noop
  noop
  noop
  noop
  noop
  addx -36
  noop
  addx 1
  addx 7
  noop
  noop
  noop
  addx 2
  addx 6
  noop
  noop
  noop
  noop
  noop
  addx 1
  noop
  noop
  addx 7
  addx 1
  noop
  addx -13
  addx 13
  addx 7
  noop
  addx 1
  addx -33
  noop
  noop
  noop
  addx 2
  noop
  noop
  noop
  addx 8
  noop
  addx -1
  addx 2
  addx 1
  noop
  addx 17
  addx -9
  addx 1
  addx 1
  addx -3
  addx 11
  noop
  noop
  addx 1
  noop
  addx 1
  noop
  noop
  addx -13
  addx -19
  addx 1
  addx 3
  addx 26
  addx -30
  addx 12
  addx -1
  addx 3
  addx 1
  noop
  noop
  noop
  addx -9
  addx 18
  addx 1
  addx 2
  noop
  noop
  addx 9
  noop
  noop
  noop
  addx -1
  addx 2
  addx -37
  addx 1
  addx 3
  noop
  addx 15
  addx -21
  addx 22
  addx -6
  addx 1
  noop
  addx 2
  addx 1
  noop
  addx -10
  noop
  noop
  addx 20
  addx 1
  addx 2
  addx 2
  addx -6
  addx -11
  noop
  noop
  noop
TEXT

def main(input)
  cycles = x = 1
  crt_rows = Array.new(6) { '                                        ' }
  input.lines.each do |line|
    line =~ /([a-z]+) *(-?\d+)?/
    instruction, argument = $1, $2
    time_to_execute = instruction == 'addx' ? 2 : 1
    (1..time_to_execute).each do |offset|
      position = (cycles + offset - 2) % 40
      crt_rows[(cycles - 1) / 40][position] = (position - x).abs < 2 ? '#' : ' '
    end
    cycles += time_to_execute
    x += argument.to_i
  end
  puts crt_rows
end

main(EXAMPLE)
main(File.read('10.input')) # PAPJCBHP
