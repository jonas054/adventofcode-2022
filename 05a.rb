EXAMPLE = <<~TEXT.freeze
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
TEXT

def main(input)
  lines = input.lines
  stacks = stacks(lines)
  move(stacks, lines)
  stacks.values.map(&:last).join
end

def stacks(lines)
  positions = positions(lines)
  stacks = Hash.new([])
  lines.grep(/\[/).reverse_each do |line|
    line.chars.each_with_index.map do |char, ix|
      stacks[positions[ix]] += [char] if char =~ /^[A-Z]$/
    end
  end
  stacks
end

def positions(lines)
  positions = {}
  lines.grep(/^ *1/).first.chars.each_with_index.map do |char, ix|
    positions[ix] = char unless char == ' '
  end
  positions
end

def move(stacks, lines)
  lines.each do |line|
    next unless line =~ /move (\d+) from (\d+) to (\d+)/

    $1.to_i.times { stacks[$3].push(stacks[$2].pop) }
  end
end

if $PROGRAM_NAME == __FILE__
  puts main(EXAMPLE) # CMZ
  puts main(File.read('05.input')) # HBTMTBSDC
end
