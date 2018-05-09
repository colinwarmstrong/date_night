require './lib/node.rb'
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
      if @root.left == nil
        @root.left = Node.new(score)
        return 1
      else
        @root.insert_node(@root.left, score, 2)
      end
    elsif @root.score < score
      if @root.right == nil
        @root.right = Node.new(score)
        return 1
      else
        @root.insert_node(@root.right, score, 2)
      end
    end
  end

  def include?(score)
    if @root == nil
      return false
    elsif @root.score > score
      @root.include_node?(@root.left, score)
    else
      @root.include_node?(@root.right, score)
    end
  end

  def depth_of(score)
    if @root == nil
      return nil
    elsif @root.score == score
      return 0
    elsif @root.score > score
      if @root.left == nil
        return nil
      else
        @root.depth_of_node(@root.left, score, 1)
      end
    elsif @root.score < score
      if @root.left == nil
        return nil
      else
        @root.depth_of_node(@root.right, score, 1)
      end
    end
  end

  def min
    @root.min_node(@root)
  end

  def max
    @root.max_node(@root)
  end

  def sort
    sorted_array = []
    sorted_array = sort_nodes(@root, sorted_array)
    return sorted_array
  end

  def sort_nodes(node, array)
    if node.left == nil
      array << node.score
    else
      sort_nodes(node.left, array)
      array << node.score
    end
    if node.right != nil
      sort_nodes(node.right, array)
    end
    return array
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
    movies_loaded_count
  end

  def height(node = @root)
    if node == nil
      return -1
    else
      left_depth = height(node.left)
      right_depth = height(node.right)
      if left_depth > right_depth
        return height = left_depth + 1
      else
        return height = right_depth + 1
      end
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
# puts tree.insert(75)
# puts tree.insert(25)
# puts tree.insert(69)
# puts tree.insert(45)
# puts tree.insert(65)
#
puts tree.include?(50)
puts tree.include?(40)
puts tree.include?(60)
puts tree.include?(30)
puts tree.include?(70)
puts tree.include?(65)
puts tree.include?(101)

puts tree.depth_of(50)
puts tree.depth_of(40)
puts tree.depth_of(60)
puts tree.depth_of(30)
puts tree.depth_of(70)
puts tree.depth_of(71)
puts tree.depth_of(69)

puts tree.min
puts tree.max

tree.sort

puts tree.height
