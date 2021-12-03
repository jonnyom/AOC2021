# frozen_string_literal: false

require_relative('../base_day')
require('pry')
class Day3 < BaseDay
  attr_accessor(:gamma, :epsilon, :max_by_hash, :result, :oxygen, :c02, :life_support)

  def initialize(sample: false, part: 'one')
    super(sample: sample, part: part)
    @gamma = ''
    @epsilon = ''
    @max_by_hash = {}
    part_one
    @result = gamma.to_i(2) * epsilon.to_i(2)
    @oxygen = []
    @c02 = []
    part_two
    @life_support = oxygen.first.to_i(2) * c02.first.to_i(2)
  end

  private

  def part_one
    input.each {|line| build_hash(max_by_hash, line.chomp) }
    build_epsilon_gamma
  end

  def part_two
    input.each {|line| init_oxygen_c02(max_by_hash, line.chomp) }
    find_oxygen_c02
  end

  def find_oxygen_c02
    (1..max_by_hash.keys.last).each do |i|
      oxygen_hash, c02_hash = prepare_oxygen_and_c02
      filter_hash(:oxygen, :select!, oxygen_hash, i)
      filter_hash(:c02, :reject!, c02_hash, i)
    end
  end

  def filter_hash(val, operator, hash, pos)
    if public_send(val).size > 1
      max = find_max(hash, pos)
      public_send(val).public_send(operator) {|line| line[pos] == max }
    end
  end

  def prepare_oxygen_and_c02
    [init_hash(:oxygen, {}), init_hash(:c02, {})]
  end

  def init_hash(val, hash)
    public_send(val).each {|line| build_hash(hash, line) }
    hash
  end

  def init_oxygen_c02(hash, line)
    max = find_max(hash, 0)
    init_val(:oxygen, line, max, :==)
    init_val(:c02, line, max, :!=)
  end

  def init_val(val, line, max, operator)
    public_send(val) << line if line[0].public_send(operator, max)
  end

  def find_max(hash, pos)
    max, count = hash[pos].max_by {|_key, v| v }
    max = '1' if is_equal(hash, pos)
    max
  end

  def is_equal(hash, pos)
    hash[pos].values.uniq.size == 1
  end

  def build_hash(hash, line)
    initialize_hash(hash, line)
    line.each_char.each_with_index {|char, i| hash[i][char] += 1 if hash[i][char] }
    hash
  end

  def build_epsilon_gamma
    max_by_hash.each do |_key, value|
      max, _count = value.max_by {|_key, v| v }
      gamma << max
      value.except(max).each {|key, _v| epsilon << key }
    end
  end

  def initialize_hash(hash, line)
    return hash unless hash.empty?

    (0...line.length).each {|i| hash[i] = { '0' => 0, '1' => 0 } }
    hash
  end
end

day_three_sample = Day3.new(sample: true)
day_three = Day3.new(sample: false)
puts("Part one sample - gamma: #{day_three_sample.gamma} epsilon: #{day_three_sample.epsilon} result: #{day_three_sample.result}")
puts("Part one - gamma: #{day_three.gamma} epsilon: #{day_three.epsilon} result: #{day_three.result}")

puts("Part two sample - gamma: #{day_three_sample.oxygen} epsilon: #{day_three_sample.c02} result: #{day_three_sample.life_support}")
puts("Part two - gamma: #{day_three.oxygen} epsilon: #{day_three.c02} result: #{day_three.life_support}")
