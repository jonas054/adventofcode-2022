EXAMPLE = <<~TEXT.freeze
  A Y
  B X
  C Z
TEXT

OWN_CHOICE = {
  'AX' => 'scissors', 'AY' => 'rock',     'AZ' => 'paper',
  'BX' => 'rock',     'BY' => 'paper',    'BZ' => 'scissors',
  'CX' => 'paper',    'CY' => 'scissors', 'CZ' => 'rock'
}
OWN_SCORE = { 'rock' => 1, 'paper' => 2, 'scissors' => 3 }
OUTCOME_SCORE = { 'X' => 0, 'Y' => 3, 'Z' => 6 }

def score(pair) = OWN_SCORE[OWN_CHOICE[pair]] + OUTCOME_SCORE[pair[1]]

def main(input) = input.lines.map(&:split).map(&:join).map { score(_1) }.sum

p main(EXAMPLE)
p main(File.read('02.input'))
