# Algorithm stolen from
# https://github.com/valogonor/advent-of-code/blob/main/2022/day12.py

EXAMPLE = <<~TEXT.freeze
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
TEXT

def main(input)
  # Map the input into a hash with positions as keys, e.g. { 0+0i => 'S', ... }
  @grid = input.lines.each_with_index.map do |line, row_index|
    line.chomp.chars.each_with_index.map { [Complex(_2, row_index), _1] }
  end.flatten(1).to_h

  p breadth_first_search(find_pos('S'), find_pos('E'))
end

def find_pos(marker) = @grid.keys.find { @grid[_1] == marker }

def breadth_first_search(start_pos, end_pos)
  seen = {}
  queue = [[start_pos]]
  while queue.any?
    path = queue.shift
    pos = path.last
    return path.length - 1 if pos == end_pos
    next if seen[pos]

    seen[pos] = true
    [0 - 1i, 0 + 1i, -1, 1].map { pos + _1 }
                           .select { @grid.key?(_1) }
                           .select { elevation(_1) - elevation(pos) < 2 }
                           .each { queue << path + [_1] }
  end
end

def elevation(pos) = @grid[pos].tr('SE', 'az').ord

main(EXAMPLE) # 31
main(File.read('12.input')) # 472
