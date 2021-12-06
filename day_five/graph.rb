# frozen_string_literal: true

class Graph
  class << self
    def build(size)
      Graph.new(iterator(size) {|x, y| Point.new(x, y) }, size)
    end

    private def iterator(size, &block)
      0.upto(size).flat_map {|y| 0.upto(size).map {|x| yield(x, y) } }
    end
  end

  attr_accessor(:points)

  def initialize(points, size)
    @points = points
    @size = size
    @points_as_hash = points.each_with_object({}) {|point, hash| hash["#{point.x},#{point.y}"] = point }
  end

  def find(point_to_find)
    @points_as_hash["#{point_to_find.x},#{point_to_find.y}"]
  end

  def dangerous_points
    points.select(&:dangerous?)
  end

  def to_s
    "#{points.each_slice(@size + 1).map {|row| row.map(&:to_s).join(' ') }.join("\n")}"
  end
end
