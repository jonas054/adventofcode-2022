# frozen_string_literal: true

p File.read('01.input').split("\n\n").map { |lunch| lunch.split.map(&:to_i).sum }.max
