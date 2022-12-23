EXAMPLE = <<~TEXT.freeze
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
TEXT

START_MARK = 'S'
END_MARK = 'E'

def main(input)
  @grid = input.lines.map(&:chomp)
  start_pos = find_pos(START_MARK)
  @end_pos = find_pos(END_MARK)
  p shortest_path_from([start_pos]).length - 1
end

def find_pos(marker)
  @grid.each_with_index do |row, y|
    row.chars.each_with_index do |char, x|
      return Complex(x, y) if char == marker
    end
  end
end

def shortest_path_from(travelled)
  output travelled
  current_pos = travelled.last
  return travelled if elevation(current_pos) == END_MARK

  climbable = steps_inside_grid(current_pos).select do |step|
    new_position = current_pos + step
    current_elevation = elevation(current_pos)
    new_elevation = elevation(new_position)
    (new_elevation == END_MARK && current_elevation.ord >= 'y'.ord) ||
      (new_elevation != END_MARK &&
       (new_elevation.ord - current_elevation.ord) < 2)
  end
  possible_next = climbable.map { current_pos + _1 } - travelled
  paths = possible_next.map { shortest_path_from(travelled + [_1]) }.compact
  successful = paths.select { elevation(_1.last) == END_MARK }

  # output successful.min_by(&:length) if successful.min_by(&:length)
  successful.min_by(&:length)
end

def steps_inside_grid(current_pos)
  order = [0 + 1i, 0 - 1i, 1 + 0i, -1 + 0i].select do |step|
    new_position = current_pos + step
    new_position.real >= 0 && new_position.real < @grid[0].length &&
      new_position.imag >= 0 && new_position.imag < @grid.length
  end
  diff = @end_pos - current_pos
  wanted_direction = Complex(max_one(diff.real), max_one(diff.imag))
  order.sort_by { sort_order(_1, wanted_direction, current_pos) }
end

def sort_order(dir, wanted_dir, current_pos)
  order = if dir == wanted_dir
            0
          elsif dir.real == wanted_dir.real
            1
          elsif dir.imag == wanted_dir.imag
            2
          else
            3
          end

  order = -100 if elevation(current_pos + dir) == END_MARK
  order -= 2 if elevation(current_pos + dir) == elevation(current_pos)
  order -= 4 if elevation(current_pos + dir) > elevation(current_pos)
  order += 4 if elevation(current_pos + dir) < elevation(current_pos)
  order
end

def max_one(n)
  n == 0 ? 0 : n / n.abs
end

def elevation(position)
  letter = @grid[position.imag][position.real]
  letter == START_MARK ? 'a' : letter
end

print "\033[2J"
print "\033[?25l"

@output_count = 0
INTERVAL = 20_000

def output(path)
  print "\033[0;0H"
  return if (@output_count += 1) % INTERVAL != 0

  @grid.each_with_index do |row, y|
    row.chars.each_with_index do |value, x|
      pos = Complex(x, y)
      if path.include?(pos)
        print(pos == path.last ? Rainbow(value).yellow : Rainbow(value).green)
      else
        print(Rainbow(value).blue)
      end
    end
    puts
  end
  printf "%.1e\n", @output_count
end

# main(EXAMPLE)
main(File.read('12.input'))
