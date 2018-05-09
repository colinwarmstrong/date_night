require './lib/node.rb'
require 'pry'

class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(score, node = @root, depth = 0)
    if node == nil
      @root = Node.new(score)
      return depth
    elsif node.score > score
      if node.left == nil
        depth += 1
        node.left = Node.new(score)
        return depth
      else
        depth += 1
        insert(score, node.left, depth)
      end
    elsif node.score < score
      if node.right == nil
        depth += 1
        node.right = Node.new(score)
        return depth
      else
        depth += 1
        insert(score, node.right, depth)
      end
    end
  end

  def include?(score, node = @root)
    if node == nil
      return false
    elsif node.score == score
      return true
    elsif node.score > score
      include?(score, node.left)
    else
      include?(score, node.right)
    end
  end

  def depth_of(score, node = @root, depth = 0)
    if node == nil
      return nil
    elsif node.score == score
      return depth
    elsif node.score > score
      depth += 1
      depth_of(score, node.left, depth)
    else
      depth += 1
      depth_of(score, node.right,  depth)
    end
  end

  def min(node = @root)
    if node.left == nil
      return node.score
    else
      min(node.left)
    end
  end

  def max(node = @root)
    if node.right == nil
      return node.score
    else
      max(node.right)
    end
  end

  def sort
    sorted_array = []
    return sort_recursion(@root, sorted_array)
  end

  def sort_recursion(node, array)
    if node.left == nil
      array << node.score
    else
      sort_recursion(node.left, array)
      array << node.score
    end
    if node.right != nil
      sort_recursion(node.right, array)
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

  def leaves(node = @root)
    if node == nil
      return 0
    elsif
      node.left == nil && node.right == nil
      return 1
    else
      left_leaves = leaves(node.left)
      right_leaves = leaves(node.right)
      return left_leaves + right_leaves
    end
  end

end

tree = BinarySearchTree.new

# tree.load('./movies.txt')

puts tree.insert(50)
puts tree.insert(40)
puts tree.insert(60)
puts tree.insert(30)
puts tree.insert(70)
puts tree.insert(75)
puts tree.insert(25)
puts tree.insert(69)
puts tree.insert(45)
puts tree.insert(65)
puts "-" * 40
puts tree.include?(50)
puts tree.include?(40)
puts tree.include?(60)
puts tree.include?(30)
puts tree.include?(70)
puts tree.include?(65)
puts tree.include?(101)
puts "-" * 40
puts tree.depth_of(50)
puts tree.depth_of(40)
puts tree.depth_of(60)
puts tree.depth_of(30)
puts tree.depth_of(70)
puts tree.depth_of(71)
puts tree.depth_of(69)
puts tree.depth_of(65)
puts "-" * 40
puts tree.min
puts tree.max
puts "-" * 40
tree.sort
puts "-" * 40
puts tree.height
puts "-" * 40
puts tree.leaves
