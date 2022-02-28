# frozen_string_literal: true

class InputReader
  attr_reader(:file_name)

  def initialize(sample: false)
    dir, file = caller.last.split(':').first.split('/').pop(2)
    @file_name = "#{dir}/inputs/#{file.split('.').first}#{sample ? '_sample' : ''}.txt"
  end

  def read_input
    File.foreach(file_name)
  end
end
