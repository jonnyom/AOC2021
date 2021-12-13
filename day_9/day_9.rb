# frozen_string_literal: true

require_relative('../base_day')

class Day9 < BaseDay
  private

  def part_one_solution
    heights = low_points.map {|x, y| matrix[x][y] }
    heights.map {|h| h + 1 }.sum
  end

  def part_two_solution
    basins =
      low_points.map do |low_point|
        basin = []
        find_basin(low_point.first, low_point.last, basin)
        basin
      end
    basins.map(&:size).sort.reverse[0...3].inject(:*)
  end

  def find_basin(row_ix, column_ix, basin)
    return basin if fetch_location(row_ix, column_ix, matrix).nil? || fetch_location(row_ix, column_ix, matrix) == 9

    basin << matrix[row_ix][column_ix]
    matrix[row_ix][column_ix] = 9
    find_basin(row_ix - 1, column_ix, basin)
    find_basin(row_ix + 1, column_ix, basin)
    find_basin(row_ix, column_ix - 1, basin)
    find_basin(row_ix, column_ix + 1, basin)
  end

  def low_points
    @low_points ||=
      matrix
      .each_with_index
      .flat_map do |row, row_ix|
        row.each_with_index.map {|elem, column_ix| [row_ix, column_ix] if locations(row_ix, column_ix).compact.all? {|n| elem < n } }
      end
      .compact
  end

  def locations(row_ix, column_ix)
    [
      fetch_location(row_ix, column_ix - 1, matrix),
      fetch_location(row_ix, column_ix + 1, matrix),
      fetch_location(row_ix - 1, column_ix, matrix),
      fetch_location(row_ix + 1, column_ix, matrix)
    ]
  end

  def matrix
    @matrix ||= input.map {|line| line.chomp.split('').map(&:to_i) }
  end
end

puts "Day 9 pt 1 sample: #{Day9.new(sample: true, part: 'one').solution}"
puts "Day 9 pt 1: #{Day9.new(sample: false, part: 'one').solution}"
puts "Day 9 pt 2 sample: #{Day9.new(sample: true, part: 'two').solution}"
puts "Day 9 pt 2: #{Day9.new(sample: false, part: 'two').solution}"
