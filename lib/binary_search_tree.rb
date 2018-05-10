require './lib/node.rb'
require 'pry'

class BinarySearchTree

  def initialize
    @root = nil
  end

  def insert(score, node = @root, depth = 0)
    if node == nil
      @root = Node.new(score)
      return depth
    elsif score < node.score
      if node.left == nil
        node.left = Node.new(score)
        return depth += 1
      else
        depth += 1
        insert(score, node.left, depth)
      end
    elsif score > node.score
      if node.right == nil
        node.right = Node.new(score)
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
    if node.score == nil
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
    movies_loaded_count
  end

  def health(depth, node = @root, health_array = [])
    if node == nil
      return nil
    elsif depth_of(node.score) == depth
      node_array = []
      children_count = count_children_nodes(node)
      children_ratio = children_count.to_f / count_children_nodes.to_f
      children_percent = (children_ratio * 100).to_i
      node_array << node.score
      node_array << children_count
      node_array << children_percent
      health_array << node_array
    else
      health(depth, node.left, health_array)
      health(depth, node.right, health_array)
    end
    health_array
  end

  def count_children_nodes(node = @root)
    if node == nil
      return 0
    else
      left_children = count_children_nodes(node.left)
      right_children = count_children_nodes(node.right)
      return left_children + right_children + 1
    end
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
    if include?(score)
      remove(score)
    else
      return nil
    end
  end

  def remove(score, node = @root)
    if node.score == score
      rebuild(score, node)
    elsif node.score > score
      remove(score, node.left)
    else
      remove(score, node.right)
    end
  end

  def rebuild(score, node)
    if node.left == nil && node.right == nil
      deleted_score = node.score
      node = nil
      return deleted_score
    elsif node.right == nil
      deleted_score = node.score
      node.score = node.left.score
      return deleted_score
    elsif node.left == nil
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

  # def rebuild(score, node)
  #   if node.left == nil && node.right == nil
  #     deleted_score = node.score
  #     node.score = nil
  #     return deleted_score
  #   elsif node.right == nil
  #     deleted_score = node.score
  #     node.score = node.left.score
  #     return deleted_score
  #   elsif node.left == nil
  #     deleted_score = node.score
  #     node.score = node.right.score
  #     return deleted_score
  #   else
  #     deleted_node_score = node.score
  #     minimum_of_right_subtree = min(node.right)
  #     node.score = minimum_of_right_subtree
  #     remove(node.score, node.right)
  #   end
  #   deleted_node_score
  # end

end

tree = BinarySearchTree.new

puts tree.load('./movies.txt')

# puts tree.depth_of(71)
# puts tree.depth_of(17)
# puts tree.depth_of(80)
# puts tree.depth_of(55)
# puts tree.depth_of(75)
# puts "-" * 40
# puts tree.health(3)
# puts tree.insert(60)
# puts tree.insert(40)
# puts tree.insert(30)
# puts tree.insert(20)
# puts tree.insert(40)
# puts tree.insert(60)
# puts tree.insert(70)
#
# puts tree.insert(80)
# puts tree.insert(30)
# puts tree.insert(70)
# puts tree.insert(80)
# puts tree.insert(30)
# puts tree.insert(20)
# puts tree.insert(10)
# puts "-" * 40
# puts tree.height
# puts tree.insert(30)
# puts tree.insert(70)
# puts tree.insert(75)
# puts tree.insert(25)
# puts tree.insert(69)
# puts tree.insert(45)
# puts tree.insert(65)
# puts tree.insert(80)
# puts tree.insert(90)
# puts "-" * 40
#
# puts tree.include?(50)
# puts tree.include?(40)
# puts tree.include?(60)
# puts tree.include?(30)
# puts tree.include?(70)
# puts tree.include?(65)
# puts tree.include?(101)
# puts "-" * 40
# puts tree.depth_of(50)
# puts tree.depth_of(40)
# puts tree.depth_of(60)
# puts tree.depth_of(30)
# puts tree.depth_of(70)
# puts tree.depth_of(71)
# puts tree.depth_of(69)
# puts tree.depth_of(65)
# puts "-" * 40
# puts tree.min
# puts tree.max
# puts "-" * 40
#
# x = tree.sort
# puts x
# puts "-" * 40
# puts tree.height
# puts "-" * 40
# puts tree.leaves

# puts tree.include?(30)
# puts tree.delete(30)
# puts tree.include?(30)
#
# puts tree.include?(71)
# puts tree.delete(71)
# puts tree.include?(71)
#
# puts tree.include?(69)
# puts tree.delete(69)
# puts tree.include?(69)

puts tree.depth_of(70)
puts tree.include?(70)
puts tree.delete(70)
puts tree.depth_of(70)
puts tree.include?(70)

# puts tree.include?(42)
# puts tree.delete(42)
# puts tree.include?(42)
#
# puts tree.include?(101)
# puts tree.delete(101)
#
# puts tree.health(0)
# puts tree.health(3)
# puts tree.health(5)
#
# puts tree.health(0)
# puts tree.health(5)
