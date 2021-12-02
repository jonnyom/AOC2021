# frozen_string_literal: true

require_relative('../base_day')

class DayTwo < BaseDay
  attr_accessor(:horizontal_position, :depth, :aim, :final_position)

  def initialize(sample: false, part: 'one')
    super(sample: sample, part: part)
    @horizontal_position = 0
    @depth = 0
    @aim = 0
    calculate_position
    @final_position = horizontal_position * depth
  end

  def calculate_position
    input.each {|position| update(position) }
  end

  private

  def update(position)
    position, count = position.split
    attribute, operator = fetch_operator[position.to_sym]
    send("update_part_#{part}".to_sym, attribute, operator, count.to_i)
  end

  def update_part_one(attribute, operator, count)
    public_send("#{attribute}=".to_sym, public_send(attribute).public_send(operator, count))
  end

  def update_part_two(attribute, operator, count)
    return handle_forward(attribute, operator, count) if attribute == :horizontal_position

    update_part_one(attribute, operator, count)
  end

  def handle_forward(attribute, operator, count)
    update_part_one(attribute, operator, count)
    self.depth += aim * count
  end

  def fetch_operator
    { forward: %i[horizontal_position +], down: [depth_or_aim, :+], up: [depth_or_aim, :-] }
  end

  def depth_or_aim
    return :depth if part_one?

    :aim
  end
end

puts("Sample part 1: #{DayTwo.new(sample: true).final_position}")
puts("Full part 1: #{DayTwo.new.final_position}")
puts("Sample part 1: #{DayTwo.new(sample: true, part: 'two').final_position}")
puts("Full part 1: #{DayTwo.new(part: 'two').final_position}")
