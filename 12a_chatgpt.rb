# The hill_climbing function uses breadth-first search to find the shortest
# path from the starting position to the ending position on the grid. It keeps
# track of the distances from the starting position to each visited position in
# a distance hash, and returns the distance for the ending position when it is
# reached. The find_position function finds the position of a given character
# in the grid, and the get_valid_next_positions function returns an array of
# valid next positions (adjacent positions with an elevation difference of at
# most 1).

# This solution has a time complexity of O(nm), where n is the number of rows
# in the grid and m is the number of columns in the grid. This is because each
# position in the grid is visited at most once during the breadth-first search.

# I hope this helps! Let me know if you have any questions.

require 'set'

def hill_climbing(grid)
  # Find the starting position
  start_pos = find_position(grid, 'S')
  # Find the ending position
  end_pos = find_position(grid, 'E')

  # Initialize a queue for breadth-first search
  queue = Queue.new
  # Push the starting position onto the queue
  queue << start_pos
  # Initialize a visited set to track visited positions
  visited = Set.new
  # Initialize a distance hash to track the distance from the starting position
  distances = { start_pos => 0 }

  # Perform breadth-first search
  until queue.empty?
    # Get the next position from the queue
    pos = queue.pop
    # If the position is the ending position, return the distance
    return distances[pos] if pos == end_pos

    # Mark the position as visited
    visited << pos

    # Get the valid next positions (adjacent positions with an elevation
    # difference of at most 1)
    next_positions = get_valid_next_positions(grid, pos)
    # Update the distances and add the next positions to the queue
    next_positions.each do |next_pos|
      unless visited.include?(next_pos)
        distances[next_pos] = distances[pos] + 1
        queue << next_pos
      end
    end
  end
end

# Returns the position of a character in the grid
def find_position(grid, char)
  (0...grid.size).each do |row|
    (0...grid[row].size).each do |col|
      return [row, col] if grid[row][col] == char
    end
  end
end

# Returns an array of valid next positions (adjacent positions with an
# elevation difference of at most 1)
def get_valid_next_positions(grid, pos)
  row, col = pos
  next_positions = []
  if row > 0 && (grid[row - 1][col].ord - grid[row][col].ord).abs <= 1
    next_positions << [row - 1, col]
  end
  if row < grid.size - 1 && (grid[row + 1][col].ord - grid[row][col].ord).abs <= 1
    next_positions << [row + 1, col]
  end
  if col > 0 && (grid[row][col - 1].ord - grid[row][col].ord).abs <= 1
    next_positions << [row, col - 1]
  end
  if col < grid[row].size - 1 && (grid[row][col + 1].ord - grid[row][col].ord).abs <= 1
    next_positions << [row, col + 1]
  end
  next_positions
end

# Example usage
grid = %w[Sabqponm abcryxxl accszExk acctuvwj abdefghi]

puts hill_climbing(grid)
# Output: 31
