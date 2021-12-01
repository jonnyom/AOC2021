# frozen_string_literal: true

require_relative('../input_reader')

class DayOne
  attr_reader(:input, :size_one, :size_two)

  def initialize
    @input = InputReader.new.read_input
    @stack_one = part_one
    @size_one = @stack_one.size
    @stack_two = part_two
    @size_two = @stack_two.size
  end

  def part_one
    tracker_stack, increment_stack = init_stacks
    input.each {|line| update_tracker_stack(line.to_i, tracker_stack, increment_stack) }
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
    update_tracker_stack(sum_stack.inject(:+), tracker_stack, increment_stack)
  end

  def update_tracker_stack(value, tracker_stack, increment_stack)
    increment_stack.push(value) if !tracker_stack.last.nil? && value > tracker_stack.last
    tracker_stack.push(value)
  end
end

puts("Sample part 1: #{DayOne.new.size_one}")
puts("Full part 1: #{DayOne.new.size_one}")
puts("Sample part 2: #{DayOne.new.size_two}")
puts("Full part 2: #{DayOne.new.size_two}")
