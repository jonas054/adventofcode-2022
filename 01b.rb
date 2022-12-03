# frozen_string_literal: true

p File.read('01.input').split("\n\n").map { _1.split.map(&:to_i).sum }.sort.last(3).sum
