# frozen_string_literal: true

require_relative('../base_day')
require_relative('lanternfish')

class Day6 < BaseDay
  attr_accessor(:lanternfish, :lanternfish_size)

  def initialize(sample: false, part: 'one')
    super(sample: sample, part: part)
    @lanternfish = fetch_lanternfish
    part_one if part_one?
    @lanternfish_size = lanternfish.size
    part_two if part_two?
  end

  private

  def fetch_lanternfish
    input.flat_map {|line| line.split(',').map {|i| LanternFish.new(i.to_i) } }
  end

  def part_one
    80.times do |i|
      lanternfish.each do |fish|
        lanternfish.push(LanternFish.new(9)) if fish.replicating?
        fish.tick
      end
      # puts("After day #{i + 1}: #{lanternfish.map(&:days_to_replication).join(', ')}")
    end
  end

  def part_two
    start = input.first.split(',').map(&:to_i)
    fish_count = (0..8).map {|day| start.count(day) || 0 }

    256.times do |i|
      fish_count.rotate!
      fish_count[6] += fish_count.last
      # puts("Day #{i}: #{fish_count.join(', ')}")
    end

    # puts("After day 256: #{fish_count.join(', ')}")
    @lanternfish_size = fish_count.sum
  end
end

puts("Day 6 sample pt 1: #{Day6.new(sample: true).lanternfish_size}")
puts("Day 6 pt 1: #{Day6.new(sample: false).lanternfish_size}")
puts("Day 6 sample pt 2: #{Day6.new(sample: true, part: 'two').lanternfish_size}")
puts("Day 6 pt 2: #{Day6.new(sample: false, part: 'two').lanternfish_size}")
