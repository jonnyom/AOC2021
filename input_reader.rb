# frozen_string_literal: true

class InputReader

  attr_reader(:file_name)

  def initialize(file_name)
    @file_name = "inputs/#{file_name}"
  end

  def read_input
    File.foreach(file_name)
  end
end