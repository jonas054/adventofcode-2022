EXAMPLE = <<~TEXT.freeze
  Monkey 0:
    Starting items: 79, 98
    Operation: new = old * 19
    Test: divisible by 23
      If true: throw to monkey 2
      If false: throw to monkey 3

  Monkey 1:
    Starting items: 54, 65, 75, 74
    Operation: new = old + 6
    Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

  Monkey 2:
    Starting items: 79, 60, 97
    Operation: new = old * old
    Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

  Monkey 3:
    Starting items: 74
    Operation: new = old + 3
    Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1
TEXT

def main(input)
  current_monkey = nil
  @monkeys = {}
  input.lines.each do |line|
    case line
    when /Monkey (\d):/
      current_monkey = $1.to_i
    when /Starting items: ([\d, ]*)/
      @monkeys[current_monkey] = { items: $1.split(', ').map(&:to_i), inspections: 0 }
    when /Operation: new = old ([+*]) (\w+)/
      @monkeys[current_monkey].merge!(operator: $1, argument: $2)
    when /Test: divisible by (\d+)/
      @monkeys[current_monkey][:divisor] = $1.to_i
    when /If (true|false): throw to monkey (\d+)/
      @monkeys[current_monkey][:destinations] ||= {}
      @monkeys[current_monkey][:destinations][$1 == 'true'] = $2.to_i
    else
      raise line unless line.strip.empty?
    end
  end
  @total_divisor = @monkeys.values.map { _1[:divisor] }.reduce(:*)
  10_000.times { run_round }
  p @monkeys.values.map { _1[:inspections] }.sort.last(2).reduce(:*)
end

def run_round
  @monkeys.each_key do |number|
    info = @monkeys[number]
    while (item = info[:items].shift)
      @monkeys[number][:inspections] += 1
      new_value = item.send(info[:operator].to_sym, operand(info, item))
      @monkeys[info[:destinations][new_value % info[:divisor] == 0]][:items] <<
        (new_value % @total_divisor)
    end
  end
end

def operand(info, item) = info[:argument] == 'old' ? item : info[:argument].to_i

main(EXAMPLE) # 2713310158
main(File.read('11.input')) # 12848882750
