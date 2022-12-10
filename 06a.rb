require 'set'

def main(input, length)
  line = input.lines.first.chomp
  pos = length
  line.chars.each_cons(length) do |chars|
    return pos if Set.new(chars).size == length

    pos += 1
  end
end

def run(length)
  p main('mjqjpqmgbljsphdztnvjfqwrcgsmlb', length) # 7
  p main('bvwbjplbgvbhsrlpgdmjqwftvncz', length) # 5
  p main('nppdvjthqldpwncqszvftbrmjlhg', length) # 6
  p main('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', length) # 10
  p main('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', length) # 11
  p main(File.read('06.input'), length) # 1779
end

run(4) if $PROGRAM_NAME == __FILE__
