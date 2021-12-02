# frozen_string_literal: true

require('pry')
require_relative('../base_day')

class DayTwo < BaseDay
  attr_accessor(:horizontal_position, :depth, :final_position)

  def initialize(sample: false)
    super(sample: sample)
    @horizontal_position = 0
    @depth = 0
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
    public_send("#{attribute}=".to_sym, public_send(attribute).public_send(operator, count.to_i))
  end

  def fetch_operator
    { forward: %i[horizontal_position +], down: %i[depth +], up: %i[depth -] }
  end
end

puts("Sample part 1: #{DayTwo.new(sample: true).final_position}")
puts("Full part 1: #{DayTwo.new.final_position}")
