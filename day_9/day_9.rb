# frozen_string_literal: true

require_relative('../base_day')

class Day9 < BaseDay
  private

  def part_one_solution
    res =
      matrix.each_with_index.flat_map do |row, row_ix|
        row.each_with_index.map do |elem, column_ix|
          top = fetch_location(row_ix, column_ix - 1)
          bottom = fetch_location(row_ix, column_ix + 1)
          left = fetch_location(row_ix - 1, column_ix)
          right = fetch_location(row_ix + 1, column_ix)
          [row_ix, column_ix] if [top, bottom, left, right].compact.all? {|n| elem < n }
        end
      end
    heights = res.compact.map {|x, y| matrix[x][y] }
    heights.map {|h| h + 1 }.sum
  end

  def fetch_location(row, column)
    return if row.negative?
    return if column.negative?

    row = matrix[row]
    return if row.nil?

    row[column]
  end

  def part_two_solution
    nil
  end

  def matrix
    @matrix ||= input.map {|line| line.chomp.split('').map(&:to_i) }
  end
end

# puts "Day 9 pt 1 sample: #{Day9.new(sample: true, part: 'one').solution}"
puts "Day 9 pt 1: #{Day9.new(sample: false, part: 'one').solution}"
