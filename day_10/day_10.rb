#  frozen_string_literal: true

require_relative('../base_day')

class Day10 < BaseDay
  private

  def part_one_solution
    invalid_symbols =
      input.map do |line|
        parse_line(line.chomp)
        nil
      rescue ArgumentError => e
        e.message
      end
    invalid_symbols = invalid_symbols.compact
    invalid_symbols.sum {|symbol| part_one_scores[symbol] }
  end

  def part_two_solution
    matches =
      input.map do |line|
        parse_line(line.chomp)
      rescue ArgumentError
        next
      end
    median(matches.compact.map {|match| calculate_score(match) })
  end

  def calculate_score(match)
    score = 0
    match.each do |symbol|
      score *= 5
      score += part_two_scores[symbol]
    end
    score
  end

  def median(array)
    return nil if array.empty?

    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2
  end

  def part_one_scores
    { '}' => 1197, ')' => 3, '>' => 25_137, ']' => 57 }
  end

  def part_two_scores
    { '}' => 3, ')' => 1, '>' => 4, ']' => 2 }
  end

  def parse_line(line)
    stack = []
    line.chars.each {|symbol| handle_symbol(symbol, stack) }
    complete_invalid_line(stack) unless stack.empty?
  end

  def handle_symbol(symbol, syntax_stack)
    syntax_stack.push(symbol) if opener?(symbol)
    return symbol if syntax_stack.empty?
    return if opener?(symbol)

    check_corrupted_line(symbol, syntax_stack)
  end

  def check_corrupted_line(symbol, syntax_stack)
    case symbol
    when ')'
      raise_for(symbol, syntax_stack.pop, ['[', '{', '<'])
    when ']'
      raise_for(symbol, syntax_stack.pop, %w[( { <])
    when '}'
      raise_for(symbol, syntax_stack.pop, ['(', '[', '<'])
    when '>'
      raise_for(symbol, syntax_stack.pop, ['(', '{', '['])
    end
  end

  def complete_invalid_line(syntax_stack)
    matches = []
    matches.push(match_char[syntax_stack.pop]) until syntax_stack.empty?
    matches
  end

  def match_char
    { '[' => ']', '<' => '>', '{' => '}', '(' => ')' }
  end

  def raise_for(symbol, val, invalid_symbols)
    raise(ArgumentError, symbol) if invalid_symbols.include?(val)
  end

  def opener?(symbol)
    openers.include?(symbol)
  end

  def openers
    ['[', '<', '{', '(']
  end
end

puts "Day 10 pt 1 sample: #{Day10.new(sample: true, part: 'one').solution}"
puts "Day 10 pt 1: #{Day10.new(sample: false, part: 'one').solution}"
puts "Day 10 pt 2 sample: #{Day10.new(sample: true, part: 'two').solution}"
puts "Day 10 pt 2 sample: #{Day10.new(sample: false, part: 'two').solution}"
