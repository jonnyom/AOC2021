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
    @winning_score = @winning_board.score(@last_number)
  end

  def run
    board_iterator do |number, board|
      next if board.winner

      @last_number = number
      board.check_number(number)

      if board.full_row?
        return @winning_board = board if part_one?

        board.winner = true
        @winning_board = board if boards.reject {|b| b.id == board.id }.all?(&:winner)
      end
    end
  end

  private

  def board_iterator(&block)
    bingo_numbers.each {|number| boards.each {|board| yield(number, board) } }
  end

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

puts "Day 4 sample one: #{Day4.new(sample: true, part: 'one').winning_score}"
puts "Day 4 part one: #{Day4.new(sample: false, part: 'one').winning_score}"
puts "Day 4 sample two: #{Day4.new(sample: true, part: 'two').winning_score}"
puts "Day 4 part two: #{Day4.new(sample: false, part: 'two').winning_score}"
