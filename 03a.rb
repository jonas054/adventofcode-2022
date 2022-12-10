EXAMPLE = <<~TEXT.freeze
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
TEXT

def main(input) = lines(input).map { find_common(_1) }.flatten.map { prio(_1) }.sum

def lines(input) = input.lines.map(&:chomp)

def find_common(items)
  half = items.length / 2
  items[0, half].chars.intersection(items[half..].chars)
end

def prio(s) = s >= 'a' ? s.ord - 'a'.ord + 1 : s.ord - 'A'.ord + 27

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 157
  p main(File.read('03.input')) # 7716
end
