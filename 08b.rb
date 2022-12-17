EXAMPLE = <<~TEXT.freeze
  30373
  25512
  65332
  33549
  35390
TEXT

def main(input)
  grid = input.lines.map { _1.chomp.chars }
  scores = grid.size.times.to_a.repeated_permutation(2).map do |x, y|
    viewing_distances(grid, x, y).reduce(:*)
  end
  scores.max
end

def viewing_distances(grid, x, y)
  row = grid[y]
  column = grid.transpose[x]
  [row[0...x].reverse, row[(x + 1)..],
   column[0...y].reverse, column[(y + 1)..]].map { line_of_sight(_1, row[x]) }
end

def line_of_sight(trees, height)
  result = 0
  trees.each do |tree|
    result += 1
    break if tree >= height
  end
  result
end

p main(EXAMPLE) # 8
p main(File.read('08.input')) # 268912
