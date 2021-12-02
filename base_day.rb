# frozen_string_literal: true

require_relative('input_reader')

class BaseDay
  attr_reader(:input)

  def initialize(sample: false)
    @input = InputReader.new(sample: sample).read_input
  end
end
