# frozen_string_literal: true

require_relative('../base_day')

class Day7 < BaseDay
  attr_reader(:solution, :crabs)

  def initialize(sample: false, part: 'one')
    super(sample: sample, part: part)
    @crabs = input.first.split(',').map(&:to_i).sort!
    @solution = send("part_#{part}_solution")
  end

  private

  def part_one_solution
    middle = crabs[crabs.length / 2]
    crabs.map {|crab| crab > middle ? crab - middle : middle - crab }.sum
  end

  def part_two_solution
    mean = (crabs.sum(0.0) / crabs.size)
    sum_one = fuel_cost(mean.floor)
    sum_two = fuel_cost(mean.ceil)
    [sum_one, sum_two].min
  end

  def fuel_cost(point)
    count =
      crabs.map do |crab|
        val = crab > point ? crab - point : point - crab
        0.upto(val).sum
      end
    count.sum
  end
end

puts("Day 7 pt 1 sample: #{Day7.new(sample: true, part: 'one').solution}")
puts("Day 7 pt 1: #{Day7.new(sample: false, part: 'one').solution}")
puts("Day 7 pt 2 sample: #{Day7.new(sample: true, part: 'two').solution}")
puts("Day 7 pt 2: #{Day7.new(sample: false, part: 'two').solution}")
