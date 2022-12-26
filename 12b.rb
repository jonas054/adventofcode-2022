require './12a'

def main(input)
  map_grid(input)
  end_pos = find_pos('E')

  path_lengths = @grid.keys.select { elevation(_1) == 'a'.ord }.map do |pos|
    breadth_first_search(pos, end_pos)
  end
  p path_lengths.compact.min
end

main(EXAMPLE) # 29
main(File.read('12.input')) # 465
