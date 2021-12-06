# frozen_string_literal: true

require_relative('row')
require_relative('column')
require('securerandom')

class Board
  attr_accessor(:rows, :id, :columns)

  def initialize
    @rows = []
    @columns = 5.times.map { Column.new }
    @id = SecureRandom.uuid
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
    columns.each {|column| column.find_value(value) }
    rows.each {|row| row.find_value(value) }
  end

  def full_row?
    columns.any?(&:full?) || rows.any?(&:full?)
  end

  def score(last_number)
    unmarked_values * last_number.to_i
  end

  def unmarked_values
    rows.map(&:unmarked_values).flatten.inject(:+)
  end
end
