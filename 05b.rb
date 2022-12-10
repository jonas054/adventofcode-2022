require './05a'

def move(stacks, lines)
  lines.each do |line|
    next unless line =~ /move (\d+) from (\d+) to (\d+)/

    how_many, from, to = $1.to_i, $2, $3
    crates = stacks[from][-how_many..]
    stacks[from][-how_many..] = []
    stacks[to] += crates
  end
end

puts main(EXAMPLE) # MCD
puts main(File.read('05.input')) # PQTJRSHWS
