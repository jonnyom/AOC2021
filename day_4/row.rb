# frozen_string_literal: true

require_relative('cell')
require_relative('board_element')

class Row < BoardElement
  def initialize(row)
    super
    @cells = row.map {|cell| Cell.new(cell) }
  end
end
