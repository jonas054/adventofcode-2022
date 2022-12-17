EXAMPLE = <<~TEXT.freeze
  30373
  25512
  65332
  33549
  35390
TEXT

def main(input)
  grid = input.lines.map { _1.chomp.chars }
  visible = grid.each_with_index.map do |line, y|
    line.each_with_index.count { visible?(grid, _1, _2, y) }
  end
  visible.sum
end

def visible?(grid, height, x, y)
  line = grid[y]
  line[0...x].all? { _1 < height } ||
    line[(x + 1)..].all? { _1 < height } ||
    grid[0...y].all? { _1[x] < height } ||
    grid[(y + 1)..].all? { _1[x] < height }
end

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 21
  p main(File.read('08.input')) # 1803
end
