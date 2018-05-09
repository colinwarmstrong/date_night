# require './lib/node.rb'
require 'pry'

class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(score)
    if @root == nil
      @root = Node.new(score)
      return 0
    elsif @root.score > score
      if @left.nil?
        @left = Node.new(score)
        return 1
      else
        @left.insert_node(score, 2)
      end
    elsif @root.score < score
      if @right.nil?
        @right = Node.new(score)
        return 1
      else
        @right.insert_node(score, 2)
      end
    end
  end

  def include?(score)
    if @root.nil?
      return false
    elsif @root.score == score
      return true
    elsif @root.score > score
      if @left.nil?
        return false
      else
        @left.include_node?(score)
      end
    elsif @root.score < score
      if @right.nil?
        return false
      else
        @right.include_node?(score)
      end
    end
  end

  def depth_of(score)
    if @root == nil
      nil
    elsif @root.score == score
      0
    elsif @root.score > score
      if @left.nil?
        return nil
      else
        @left.depth_of_node(score, 1)
      end
    elsif @root.score < score
      if @right.nil?
        return nil
      else
        @right.depth_of_node(score, 1)
      end
    end
  end

  def max
    if @right.nil?
      return @score
    else
      @right.max_node
    end
  end

  def min
    if @left.nil?
      return @score
    else
      @left.min_node
    end
  end

  def sort
    sorted_array = []
    if @left.nil
      sorted_array << @score
    else
      @left.sort_node(@root, sorted_array)
    end
  end

  def load(file)
    movies_loaded_count = 0
    array_of_movie_lines = File.readlines(file)
    array_of_movie_lines.each do |movie|
      movie_line_array = movie.split(',')
      if include?(movie_line_array[0].to_i)
        next
      else
        movies_loaded_count += 1
        insert(movie_line_array[0].to_i)
      end
    end
    puts movies_loaded_count
    movies_loaded_count
  end

end


class Node

  attr_accessor :score,
                :left,
                :right

  def initialize(score)
    @score = score
  end

  def insert_node(score, depth)
    if @score > score
      if @left.nil?
        @left = Node.new(score)
        return depth
      else
        depth += 1
        @left.insert_node(score, depth)
      end
    elsif @score < score
      if @right.nil?
        @right = Node.new(score)
        return depth
      else
        depth += 1
        @right.insert_node(score, depth)
      end
    end
  end

  def include_node?(score)
    if @score == score
      return true
    elsif @score > score
      if @left.nil?
        return false
      else
        @left.include_node?(score)
      end
    elsif @score < score
      if @right.nil?
        return false
      else
        @right.include_node?(score)
      end
    end
  end

  def depth_of_node(score, depth)
    if @score == score
      return depth
    elsif @score > score
      if @left.nil?
        return nil
      else
        depth += 1
        @left.depth_of_node(score, depth)
      end
    elsif @score < score
      if @right.nil?
        return nil
      else
        depth += 1
        @right.depth_of_node(score, depth)
      end
    end
  end

  def max_node
    if @right.nil?
      return @score
    else
      @right.max_node
    end
  end

  def min_node
    if @left.nil?
      return @score
    else
      @left.min_node
    end
  end

end

tree = BinarySearchTree.new

tree.load('./movies.txt')

# puts tree.insert(50)
# puts tree.insert(40)
# puts tree.insert(60)
# puts tree.insert(30)
# puts tree.insert(70)
# puts tree.insert(35)
# puts tree.insert(65)
# puts tree.insert(67)
# puts tree.insert(71)
# puts tree.insert(29)

puts tree.include?(50)
puts tree.include?(60)
puts tree.include?(69)
puts tree.include?(67)
puts tree.include?(40)
puts tree.include?(19)
puts tree.include?(1)

puts tree.depth_of(50)
puts tree.depth_of(60)
puts tree.depth_of(40)
puts tree.depth_of(30)
puts tree.depth_of(67)
puts tree.depth_of(33)
puts tree.depth_of(29)

puts tree.max
puts tree.min
