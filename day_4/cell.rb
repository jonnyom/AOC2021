# frozen_string_literal: true

class Cell
  attr_accessor(:value, :found)

  def initialize(value)
    @value = value
    @found = false
  end

  def to_s
    "#{found ? '!' : ''}#{value}"
  end
end
