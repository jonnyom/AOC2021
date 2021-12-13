# frozen_string_literal: true

require_relative('../base_day')

class Day11 < BaseDay
  private

  def part_one_solution
    flash_count = 1.upto(100).sum {|step| find_flashlight_positions(step) }
    flash_count
  end

  def part_two_solution
    count = 1
    loop do
      find_flashlight_positions(count)
      count += 1
    end
  rescue ArgumentError
    count
  end

  def find_flashlight_positions(step)
    flashed = Array.new(octopi.size) { Array.new(octopi.first.size) { false } }
    octopi.each_with_index {|column, x| column.each_with_index {|_cell, y| flash_octopus_light(x, y, flashed) } }
    raise(ArgumentError, 'We are done') if part_two? && flashed.flatten.uniq == [true]

    octopi.sum {|row| row.count {|cell| cell.zero? } }
  end

  def flash_octopus_light(x, y, flashed)
    return if fetch_location(x, y, flashed).nil? || flashed_this_step?(x, y, flashed)

    octopi[x][y] += 1 unless flashed_this_step?(x, y, flashed)
    if octopi[x][y] > 9
      flashed[x][y] = true
      octopi[x][y] = 0
      flash_neighbours(x, y, flashed)
    end
  end

  def flash_neighbours(x, y, flashed)
    ###
    #  [x-1,y-1] [x,y-1] [x+1,y-1]
    #  [x-1,y]   [x,y]   [x+1,y]
    #  [x-1,y+1] [x,y+1] [x+1,y+1]
    ###
    flash_octopus_light(x - 1, y - 1, flashed)
    flash_octopus_light(x, y - 1, flashed)
    flash_octopus_light(x + 1, y - 1, flashed)
    flash_octopus_light(x - 1, y, flashed)
    flash_octopus_light(x + 1, y, flashed)
    flash_octopus_light(x - 1, y + 1, flashed)
    flash_octopus_light(x, y + 1, flashed)
    flash_octopus_light(x + 1, y + 1, flashed)
  end

  def flashed_this_step?(x, y, flashed)
    fetch_location(x, y, flashed)
  end

  def octopi
    @octopi ||= input.map {|line| line.chomp.each_char.map(&:to_i) }
  end
end

puts "Day 11 pt 1 sample: #{Day11.new(sample: true, part: 'one').solution}"
puts "Day 11 pt 1: #{Day11.new(sample: false, part: 'one').solution}"
puts "Day 11 pt 2 sample: #{Day11.new(sample: true, part: 'two').solution}"
puts "Day 11 pt 2: #{Day11.new(sample: false, part: 'two').solution}"
