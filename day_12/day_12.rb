# frozen_string_literal: true

require_relative('../base_day')

class Node
  attr_reader(:name, :revisitable, :connections)
  attr_accessor(:visited)

  def initialize(name)
    @name = name
    @connections = []
    @visited = false
  end

  def add_connection(node)
    @connections.push(node) unless connections.include?(node)
  end

  def start?
    @name == 'start'
  end

  def end?
    @name == 'end'
  end

  def revisitable?
    name == name.upcase && !start? && !end?
  end

  def ==(other)
    other.name == name
  end
end

class Graph
  attr_reader(:nodes, :paths)
  attr_accessor(:path_count)

  def initialize
    @nodes = []
    @paths = []
    @path_count = 0
  end

  def add(*nodes)
    nodes.each {|node| @nodes.push(node) unless contains?(node) }
  end

  def add_path(path)
    @paths.push(path) unless @paths.include?(path)
  end

  def contains?(node)
    @nodes.include?(node)
  end

  def find(node_name)
    @nodes.find {|n| n.name == node_name }
  end

  def head
    @nodes.find(&:start?)
  end

  def tail
    @nodes.find(&:end?)
  end

  def all_visited?
    @nodes.all?(&:visited?)
  end

  def non_revisitable_nodes
    @non_revisitable_nodes ||= @nodes.reject(&:revisitable?)
  end

  def revisitable_once_nodes
    @revisitable_once_nodes ||= non_revisitable_nodes.reject {|n| n.start? || n.end? }.map(&:name)
  end
end

class Day12 < BaseDay
  def graph
    @graph ||= Graph.new
  end

  def part_one_solution
    input.each {|line| build_graph(line.chomp) }

    build_path(graph.head, [graph.head.name], {})
    graph.path_count
  end

  def build_graph(line)
    a, b = line.split('-')
    graph.add(Node.new(a), Node.new(b))
    node_a = graph.find(a)
    node_b = graph.find(b)
    node_a.add_connection(node_b)
    node_b.add_connection(node_a)
  end

  def build_path(node, path, visited)
    visited[node.name] ? visited[node.name] += 1 : visited[node.name] = 1
    
    if node.end?
      graph.path_count += 1
    else
      node.connections.each do |connection|
        build_path(connection, path, visited) if process_connection?(connection, visited)          
      end
    end
    visited[node.name] = 0
  end

  def process_connection?(connection, visited_nodes)
    return !visited_nodes[connection.name] && connection.revisitable? if part_one?
    
    visited = visited_nodes.slice(*graph.revisitable_once_nodes)
    puts visited
    return false if connection.start?
    return true if connection.revisitable?
    return true if visited_nodes[connection.name].nil?
    return false if visited.values.any? {|n| n >= 2 }

    # return true if visited_nodes[connection.name]

    true
  end
end

puts "Day 12 pt 1 sample: #{Day12.new(sample: true, part: 'one').solution}"
# puts "Day 12 pt 1: #{Day12.new(sample: false, part: 'one').solution}"
