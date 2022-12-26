require './14a'

def main(input)
  parse(input)
  drop_sand
  puts @grid.values.count('o')
end

def drop_sand
  loop do
    sand = 500
    loop do
      if sand.imag == @bottom + 1 || DIRECTIONS.all? { @grid.key?(sand + _1) }
        @grid[sand] = 'o'
        sand.imag == 0 ? return : break
      end

      sand += Complex(DIRECTIONS.find { !@grid.key?(sand + _1) }.real, 1)
    end
  end
end

main(EXAMPLE) # 93
main(File.read('14.input')) # 27426
