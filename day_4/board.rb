# frozen_string_literal: true

require_relative('row')
require_relative('column')
require('securerandom')

class Board
  attr_accessor(:rows, :id, :columns, :winner)

  def initialize
    @rows = []
    @columns = 5.times.map { Column.new }
    @id = SecureRandom.uuid
    @winner = false
  end

  def add_row_and_columns(row)
    row = row.split
    rows << Row.new(row)
    row.each_with_index {|column, i| columns[i].add_cell(column) }
  end

  def to_s
    rows.map(&:to_s).join("\n")
  end

  def full?
    rows.size == 5
  end

  def check_number(value)
    rows.each {|row| row.find_value(value) }
    columns.each {|column| column.find_value(value) }
  end

  def full_row?
    full_column || full_row
  end

  def full_column
    @full_column ||= columns.find(&:full?)
  end

  def full_row
    @full_row ||= rows.find(&:full?)
  end

  def score(last_number)
    unmarked_values.to_i * last_number.to_i
  end

  def unmarked_values
    rows.map(&:unmarked_values).flatten.inject(:+)
  end
end
