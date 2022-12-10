EXAMPLE = <<~TEXT.freeze
  A Y
  B X
  C Z
TEXT

OWN_SCORE = { 'rock' => 1, 'paper' => 2, 'scissors' => 3 }
OUTCOME_SCORE = {
  'paper-rock' => 0, 'rock-scissors' => 0, 'scissors-paper' => 0,
  'rock-rock' => 3, 'scissors-scissors' => 3, 'paper-paper' => 3,
  'paper-scissors' => 6, 'rock-paper' => 6, 'scissors-rock' => 6
}

def translate(s) = s.gsub(/[AX]/, 'rock').gsub(/[BY]/, 'paper').gsub(/[CZ]/, 'scissors')

def score(pair)
  OWN_SCORE[translate(pair[-1])] + OUTCOME_SCORE[translate(pair)]
end

def main(input) = process(input).map { _1.join('-') }.map { score(_1) }.sum

def process(input) = input.lines.map(&:split)

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 15
  p main(File.read('02.input')) # 13526
end
