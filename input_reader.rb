# frozen_string_literal: true

class InputReader
  attr_reader(:file_name)

  def initialize
    dir, file = caller.last.split(':').first.split('/')
    @file_name = "#{dir}/inputs/#{file.split('.').first}.txt"
  end

  def read_input
    File.foreach(file_name)
  end
end
