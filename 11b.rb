require './11a'

def run_calculation
  @total_divisor = @monkeys.values.map { _1[:divisor] }.reduce(:*)
  10_000.times { run_round }
end

def end_value(new_value) = new_value % @total_divisor
def divisible?(new_value, _end_value, info) = new_value % info[:divisor] == 0

main(EXAMPLE) # 2713310158
main(File.read('11.input')) # 12848882750
