require './02a'

OWN_CHOICE = {
  'AX' => 'scissors', 'AY' => 'rock',     'AZ' => 'paper',
  'BX' => 'rock',     'BY' => 'paper',    'BZ' => 'scissors',
  'CX' => 'paper',    'CY' => 'scissors', 'CZ' => 'rock'
}

def score(pair) = OWN_SCORE[OWN_CHOICE[pair]] + pair[1].tr('XYZ', '036').to_i

def main(input) = process(input).map(&:join).map { score(_1) }.sum

p main(EXAMPLE) # 12
p main(File.read('02.input')) # 14204
