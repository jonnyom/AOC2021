# frozen_string_literal: true

require_relative('../base_day')
class Day8 < BaseDay
  private

  def part_one_solution
    input.sum {|line| break_down_line(line).last.count {|i| [2, 3, 4, 7].include?(i.size) } }
  end

  def part_two_solution
    input.sum do |line|
      input, output = break_down_line(line)
      map = fetch_map(input)
      output.map {|digit| map.key(digit) }.join.to_i
    end
  end

  # I did not come up with this on my own and it makes me sad
  def fetch_map(line)
    map = {}
    map[1] = line.find {|c| c.size == 2 }
    map[4] = line.find {|c| c.size == 4 }
    map[7] = line.find {|c| c.size == 3 }
    map[8] = line.find {|c| c.size == 7 }
    map[6] = line.find {|c| c.size == 6 && (c - map[1]).size == 5 }
    map[9] = line.find {|c| c.size == 6 && (c - map[4]).size == 2 }
    map[0] = line.find {|c| c.size == 6 && (c != map[6]) && c != map[9] }
    map[3] = line.find {|c| c.size == 5 && (c - map[1]).size == 3 }
    map[2] = line.find {|c| c.size == 5 && (c - map[9]).size == 1 }
    map[5] = line.find {|c| c.size == 5 && c != map[2] && c != map[3] }
    map
  end

  def break_down_line(line)
    line.split(' | ').map {|l| l.split.map {|c| c.chars.sort } }
  end
end

puts "Day 8 pt 1 sample: #{Day8.new(sample: true, part: 'one').solution}"
puts "Day 8 pt 1: #{Day8.new(sample: false, part: 'one').solution}"
puts "Day 8 pt 1 sample: #{Day8.new(sample: true, part: 'two').solution}"
puts "Day 8 pt 1: #{Day8.new(sample: false, part: 'two').solution}"
