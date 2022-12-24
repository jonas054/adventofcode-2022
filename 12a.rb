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
  @grid = input.lines.map(&:chomp)
  p breadth_first_search(find_pos('S'), find_pos('E'))
end

def find_pos(marker)
  @grid.each_with_index do |row, y|
    row.chars.each_with_index do |char, x|
      return Complex(x, y) if char == marker
    end
  end
end

def breadth_first_search(start_pos, end_pos)
  seen = {}
  queue = [[start_pos]]
  while queue.any?
    path = queue.shift
    pos = path.last
    next if seen.include?(pos)
    return path.length - 1 if pos == end_pos

    seen[pos] = true
    [0 - 1i, 0 + 1i, -1, 1].each do |dir|
      new_pos = pos + dir
      next unless (0...@grid.length).cover?(new_pos.imag) &&
                  (0...@grid[0].length).cover?(new_pos.real)
      next unless elevation(new_pos) - elevation(pos) < 2

      queue << path + [new_pos]
    end
  end
end

def elevation(position)
  letter = @grid[position.imag][position.real]
  case letter
  when 'S' then 'a'
  when 'E' then 'z'
  else letter
  end.ord
end

main(EXAMPLE) # 31
main(File.read('12.input')) # 472
