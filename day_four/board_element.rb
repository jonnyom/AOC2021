#  frozen_string_literal: true

class BoardElement
  attr_accessor(:cells)

  def initialize
    @cells = []
  end

  def add_cell(value)
    cells << Cell.new(value)
  end

  def to_s
    cells.map(&:to_s).join(' ')
  end

  def find_value(value)
    found_cell = cells.find {|cell| cell.value == value }
    return unless found_cell

    found_cell.found = true
  end

  def full?
    cells.all?(&:found)
  end

  def unmarked_values
    cells.reject(&:found).map(&:value).map(&:to_i)
  end
end
