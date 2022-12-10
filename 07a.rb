EXAMPLE = <<~TEXT.freeze
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
TEXT

def main(input)
  size_map(parse(input.lines.map(&:chomp))).values.select { _1 <= 100_000 }.sum
end

def parse(lines)
  tree = {}
  current_dir = nil
  lines.each do |line|
    case line
    when /\$ cd (.*)/
      current_dir = change_dir(current_dir, $1)
      tree[current_dir] ||= { dirs: [] }
    when /^dir (.*)/
      tree[current_dir][:dirs] << File.join(current_dir, $1)
    when /^(\d+) (.*)/
      tree[current_dir][$2] = $1.to_i
    end
  end
  tree
end

def change_dir(current_dir, dir)
  case dir
  when %r{^/} then dir
  when '..' then File.dirname(current_dir)
  when /\w+/ then File.join(current_dir, dir)
  end
end

def size_map(tree)
  tree.map { [_1, size(tree, _2)] }.to_h
end

def size(tree, contents)
  contents.values_at(*(contents.keys - [:dirs])).sum +
    contents[:dirs].map { size(tree, tree[_1]) }.sum
end

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 95437
  p main(File.read('07.input')) # 1432936
end
