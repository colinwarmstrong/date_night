#  srequire './lib/node.rb'
require 'pry'

class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(score)
    if @root == nil
      @root == Node.new(score)
      return 0
    else
      @root.insert_node(@root, score, 1)
    end
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
        @root.left.insert_node(@root.left, score, 2)
      end
    elsif @root.score < score
      if @root.right == nil
        @root.right = Node.new(score)
        return 1
      else
        @root.right.insert_node(@root.right, score, 2)
      end
    end
  end

  def include?(score)
    if @root == nil?
      return false
    elsif @root.score == score
      return true
    elsif @root.score > score
      if @root.left == nil
        return false
      else
        @root.left.include_node?(score)
      end
    elsif @root.score < score
      if @root.right == nil
        return false
      else
        @root.right.include_node?(score)
      end
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

  def load(file)
    movies_loaded_count = 0
    array_of_movie_lines = File.readlines(file)
    array_of_movie_lines.each do |movie|
      movie_line_array = movie.split(',')
      if include?(movie_line_array[0].to_i)
        puts "DUPLICATE #{movie}"
        next
      else
        movies_loaded_count += 1
        insert(movie_line_array[0].to_i)
      end
    end
    movies_loaded_count
  end

  def sort_nodes
    sorted_array = []
    sort(@root, sorted_array)
    puts sorted_array
  end

  def sort(node, array)
    if node.left == nil
      array << node.score
    else
      sort(node.left, array)
      array << node.score
    end
    if node.right != nil
      sort(node.right, array)
    end
    return array
  end

end


class Node

  attr_accessor :score,
                :left,
                :right

  def initialize(score)
    @score = score
  end

  def insert_node(node, score, depth)
    if node.score > score
      if node.left == nil
        node.left = Node.new(score)
        return depth
      else
        depth += 1
        insert_node(node.left, score, depth)
      end
    elsif node.score < score
      if node.right == nil
        node.right = Node.new(score)
        return depth
      else
        depth += 1
        insert_node(node.right, score, depth)
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

  def depth_of_node(node, score, depth)
    if node.score == score
      return depth
    elsif node.score > score
      if node.left == nil
        return nil
      else
        depth += 1
        depth_of_node(node.left, score, depth)
      end
    elsif node.score < score
      if node.right == nil
        return nil
      else
        depth += 1
        depth_of_node(node.right, score, depth)
      end
    end
  end

  def min_node(node)
    if node.left == nil
      return node.score
    else
      min_node(node.left)
    end
  end

  def max_node(node)
    if node.right == nil
      return node.score
    else
      max_node(node.right)
    end
  end

end

tree = BinarySearchTree.new

# puts tree.load('./movies.txt')

puts tree.insert(50)
puts tree.insert(40)
puts tree.insert(60)
puts tree.insert(30)
puts tree.insert(70)
puts tree.insert(75)
puts tree.insert(25)
puts tree.insert(69)
puts tree.insert(45)

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

# puts tree.sort_nodes
