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
    invalid_symbols.sum {|symbol| scores[symbol] }
  end

  def scores
    { '}' => 1197, ')' => 3, '>' => 25_137, ']' => 57 }
  end

  def parse_line(line)
    stack = []
    line.chars.each {|symbol| invalid_symbol = handle_symbol(symbol, stack) }
  end

  def handle_symbol(symbol, syntax_stack)
    syntax_stack.push(symbol) if opener?(symbol)
    return symbol if syntax_stack.empty?
    return if opener?(symbol)

    check_for_closer(symbol, syntax_stack)
  end

  def check_for_closer(symbol, syntax_stack)
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
