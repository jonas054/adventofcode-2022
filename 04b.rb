require './04a'

def overlap?(a, b) = a.intersect?(b)

p main(EXAMPLE) # 4
p main(File.read('04.input')) # 917
