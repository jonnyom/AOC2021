# frozen_string_literal: true

require_relative('input_reader')

class DayOne
  attr_reader(:input, :size_one, :size_two)

  def initialize(file_name: 'day_1.txt')
    @input = InputReader.new(file_name).read_input
    @stack_one = part_one
    @size_one = @stack_one.size
    @stack_two = part_two
    @size_two = @stack_two.size
  end

  def part_one
    tracker_stack, increment_stack = init_stacks
    input.each do |line|
      increment_stack.push(line.to_i) if !tracker_stack.last.nil? && line.to_i > tracker_stack.last
      tracker_stack.push(line.to_i)
    end
    increment_stack
  end

  def part_two
    tracker_stack, increment_stack = init_stacks
    sum_stack = []
    input.each do |line|
      manage_stack(sum_stack, line)
      next unless sum_stack.size == 3

      inject_sum(sum_stack, increment_stack, tracker_stack)
    end
    increment_stack
  end

  private

  def init_stacks
    [[], []]
  end

  def manage_stack(sum_stack, line)
    sum_stack.push(line.to_i)
    sum_stack.shift if sum_stack.size > 3
  end

  def inject_sum(sum_stack, increment_stack, tracker_stack)
    sum = sum_stack.inject(:+)
    increment_stack.push(sum) if !tracker_stack.last.nil? && sum > tracker_stack.last
    tracker_stack.push(sum)
  end
end

puts("Sample part 1: #{DayOne.new(file_name: 'day_1_sample.txt').size_one}")
puts("Full part 1: #{DayOne.new.size_one}")
puts("Sample part 2: #{DayOne.new(file_name: 'day_1_sample.txt').size_two}")
puts("Full part 2: #{DayOne.new.size_two}")
