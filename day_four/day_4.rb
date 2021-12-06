# frozen_string_literal: true

require('pry')
require_relative('../base_day')
require_relative('board')

class Day4 < BaseDay
  attr_accessor(:boards, :bingo_numbers, :winning_board, :winning_score)

  def initialize(sample: false, part: 'one')
    super(sample: sample, part: part)
    @bingo_numbers = input.first.split(',')
    @boards = build_boards
    @winning_board = nil
    @last_number = nil
    run
    @winning_score = winning_board.score(@last_number)
  end

  def run
    bingo_numbers.each do |number|
      boards.each do |board|
        board.check_number(number)

        if board.full_row?
          @last_number = number
          return @winning_board = board
        end
      end
    end
  end

  private

  def build_boards
    built_boards = []
    board = Board.new
    input.each do |line|
      next if skip_line?(line)

      board.add_row_and_columns(line)
      if board.full?
        built_boards << board
        board = Board.new
      end
    end
    built_boards.compact
  end

  def skip_line?(line)
    line.include?(',') || line.empty? || line == "\n"
  end
end

puts "Day 4 sample: #{Day4.new(sample: true, part: 'one').winning_score}"
puts "Day 4 part one: #{Day4.new(sample: false, part: 'one').winning_score}"
