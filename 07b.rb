require './07a'

AVAILABLE_SPACE = 70_000_000
NEEDED_SPACE = 30_000_000

def main(input)
  size_map = size_map(parse(input.lines.map(&:chomp)))
  to_delete = size_map['/'] + NEEDED_SPACE - AVAILABLE_SPACE
  size_map.values.select { _1 >= to_delete }.min
end

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 24933642
  p main(File.read('07.input')) # 272298
end
