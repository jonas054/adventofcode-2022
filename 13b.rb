require './13a'

EXTRA = [[[2]], [[6]]]

def main(input)
  packets = (input.split.map { eval(_1) } + EXTRA).sort { compare(_1, _2) }
  p EXTRA.map { 1 + packets.index(_1) }.reduce(:*)
end

main(EXAMPLE) # 140
main(File.read('13.input')) # 21922
