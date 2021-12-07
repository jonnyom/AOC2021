# frozen_string_literal: true

class Point
  attr_reader(:x, :y, :count)

  def initialize(x_val, y_val)
    @x = x_val
    @y = y_val
    @count = 0
  end

  def overlapped
    @count += 1
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def dangerous?
    count > 1
  end

  def to_s
    @count.positive? ? count : '.'
  end
end
