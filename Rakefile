# frozen_string_literal: true

task :default do
  newest = Dir['[0-9b]*.rb'].max_by { File.new(_1).mtime }
  sh 'rubocop -A'
  ruby "-I. -rrainbow -rdebugging #{newest}"
end
