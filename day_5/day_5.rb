# frozen_string_literal: true

require('pry')
require_relative('../base_day')
require_relative('point')
require_relative('graph')

class Day5 < BaseDay
  attr_reader(:danger_size)

  def initialize(sample: false, part: 'one')
    super(sample: sample, part: part)
    @graph = Graph.build(sample ? 9 : 999)
    populate_graph

    # puts(@graph.to_s)
    @danger_size = @graph.dangerous_points.size
  end

  private

  def populate_graph
    positions = build_positions
    positions.each {|position| position.each {|point| @graph.find(point)&.overlapped } }
  end

  def build_positions
    input.map {|line| handle_line(line) }
  end

  def handle_line(line)
    values = line.split(' -> ')
    x1, y1 = values[0].split(',').map(&:to_i)
    x2, y2 = values[1].split(',').map(&:to_i)
    find_position(x1, y1, x2, y2)
  end

  def find_position(x1, y1, x2, y2)
    if x1 == x2
      build_x_range(x1, y1, y2)
    elsif y1 == y2
      build_y_range(y1, x1, x2)
    else
      part_two? ? find_part_two_position(x1, y1, x2, y2) : []
    end
  end

  def build_x_range(x, y1, y2)
    y1 > y2 ? y1.downto(y2).map {|y| build_point(x, y) } : y1.upto(y2).map {|y| build_point(x, y) }
  end

  def build_y_range(y, x1, x2)
    x1 > x2 ? x1.downto(x2).map {|x| build_point(x, y) } : x1.upto(x2).map {|x| build_point(x, y) }
  end

  def find_part_two_position(x1, y1, x2, y2)
    x_vals = x1 > x2 ? x1.downto(x2).to_a : x1.upto(x2).to_a
    y_vals = y1 > y2 ? y1.downto(y2).to_a : y1.upto(y2).to_a
    x_vals.each_with_index.map {|x, index| build_point(x, y_vals[index]) }
  end

  def build_point(x, y)
    Point.new(x, y)
  end
end

puts "Day 5 sample: #{Day5.new(sample: true, part: 'one').danger_size}"
puts "Day 5: #{Day5.new(sample: false, part: 'one').danger_size}"
puts "Day 5 sample pt 2: #{Day5.new(sample: true, part: 'two').danger_size}"
puts "Day 5 pt 2: #{Day5.new(sample: false, part: 'two').danger_size}"
