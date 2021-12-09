# frozen_string_literal: true

require('pry')
require_relative('input_reader')

class BaseDay
  attr_reader(:input, :part, :solution)

  def initialize(sample: false, part: 'one')
    @input = InputReader.new(sample: sample).read_input
    @part = part
    @solution = send("part_#{part}_solution")
  end

  def part_one?
    part == 'one'
  end

  def part_two?
    part == 'two'
  end
end
