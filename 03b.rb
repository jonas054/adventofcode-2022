require './03a'

def main(input)
  lines(input).each_with_index
              .group_by { |_, ix| ix / 3 }
              .map { find_common(_2.map(&:first).map(&:chars)) }
              .flatten
              .map { prio(_1) }
              .sum
end

def find_common(items) = items.reduce { _1.intersection(_2) }

p main(EXAMPLE) # 70
p main(File.read('03.input')) # 2973
