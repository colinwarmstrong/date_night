require './lib/node.rb'
require 'pry'

class BinarySearchTree

  def initialize
    @root = nil
    @total_nodes = 0
  end

  # def insert(score, node = @root, depth = 0)
  #   if node == nil
  #     node = Node.new(score)
  #     return depth
  #   elsif score < node.score
  #     depth += 1
  #     insert(score, node.left, depth)
  #   else
  #     depth += 1
  #     insert(score, node.right, depth)
  #   end
  # end

  def insert(score, node = @root, depth = 0)
    if node == nil
      @root = Node.new(score)
      return depth
    elsif score < node.score
      if node.left == nil
        node.left = Node.new(score)
        @total_nodes += 1
        return depth += 1
      else
        depth += 1
        insert(score, node.left, depth)
      end
    elsif score > node.score
      if node.right == nil
        node.right = Node.new(score)
        @total_nodes += 1
        return depth += 1
      else
        depth += 1
        insert(score, node.right, depth)
      end
    else
      return nil
    end
  end

  def include?(score, node = @root)
    if node == nil
      return false
    elsif node.score == nil
      return false
    elsif score == node.score
      return true
    elsif score < node.score
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
    if @root == nil
      return nil
    elsif node.left == nil
      return node.score
    else
      min(node.left)
    end
  end

  def max(node = @root)
    if @root == nil
      return nil
    elsif node.right == nil
      return node.score
    else
      max(node.right)
    end
  end

  def health(depth, node = @root)
    health_array = []
    node_array = []
    if depth_of(node.score) == depth
      node_array << node.score
    else
      health(depth, node.left)
    end
    if node.right != nil
      health(depth, node.right)
    end
  end

  def find_children_nodes(node = @root, node_count = 1)
    if @root == nil
      return nil
    elsif node.left == nil
      puts "LEFT NODE IS NIL"
      node_count += 1
    else
      "RECURSION"
      find_children_nodes(node.left, node_count)
      node_count += 1
    end
    if node.right != nil
      "RIGHT NODE IS NOT NIL, GO RIGHT"
      find_children_nodes(node.right, node_count)
      node_count += 1
    end
    return node_count
  end

  def sort
    if @root == nil
      return nil
    else
      sorted_array = []
      sorted_array_of_movies = sort_recursion(@root, sorted_array)
      return sorted_array_of_movies
    end
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
    @total_nodes += movies_loaded_count
    movies_loaded_count
  end

  def height(node = @root)
    if node == nil
      return -1
    else
      left_depth = height(node.left)
      right_depth = height(node.right)
      if left_depth > right_depth
        return height_of_tree = left_depth + 1
      else
        return height_of_tree = right_depth + 1
      end
    end
  end

  def leaves(node = @root)
    if node == nil
      return 0
    elsif node.left == nil && node.right == nil
      return 1
    else
      left_leaves = leaves(node.left)
      right_leaves = leaves(node.right)
      return left_leaves + right_leaves
    end
  end

  def delete(score, node = @root)
    puts "--DELETE--"
    if include?(score)
      puts "SCORE IS INCLUDED"
      remove(score)
    else
      return nil
    end
  end

  def remove(score, node = @root)
    puts "--REMOVE--"
    if node.score == score
      puts "SCORE EQUALS NODE"
      rebuild(score, node)
    elsif node.score > score
      puts "SCORE IS LESS THAN NODE, GO LEFT"
      remove(score, node.left)
    else
      puts "SCORE IS MORE THAN NODE, GO RIGHT"
      remove(score, node.right)
    end
  end

  def rebuild(score, node)
    puts '--REBUILD--'
    if node.left == nil && node.right == nil
      puts "SCORE IS LEAF, COOL BEANS"
      deleted_score = node.score
      node.score = nil
      return deleted_score
    elsif node.right == nil
      puts "NODE HAS NO RIGHT NODE, INSERT LEFT NODE"
      deleted_score = node.score
      node.score = node.left.score
      return deleted_score
    elsif node.left == nil
      puts "NODE HAS NO LEFT NODE, INSERT RIGHT NODE"
      deleted_score = node.score
      node.score = node.right.score
      return deleted_score
    else
      deleted_node_score = node.score
      minimum_of_right_subtree = min(node.right)
      node.score = minimum_of_right_subtree
      remove(node.score, node.right)
    end
    deleted_node_score
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
puts tree.insert(80)
puts tree.insert(90)
puts "-" * 40

puts tree.include?(70)
puts tree.delete(70)
puts tree.include?(70)

# puts tree.find_children_nodes

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

x = tree.sort
puts x
puts "-" * 40
puts tree.height
puts "-" * 40
puts tree.leaves

puts tree.include?(30)

puts tree.delete(30)

puts tree.include?(30)
