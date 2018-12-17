require './lib/node.rb'

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(score, node = @root, depth = 0)
    if node.nil?
      @root = Node.new(score)
      depth
    elsif score < node.score
      if node.left.nil?
        node.left = Node.new(score)
        depth
      else
        insert(score, node.left, depth + 1)
      end
    elsif score > node.score
      if node.right.nil?
        node.right = Node.new(score)
        depth
      else
        insert(score, node.right, depth + 1)
      end
    end
    depth
  end

  def include?(score, node = @root)
    if node.nil?
      false
    elsif score == node.score
      true
    elsif score < node.score
      include?(score, node.left)
    else
      include?(score, node.right)
    end
  end

  def depth_of(score, node = @root, depth = 0)
    if node.nil?
      nil
    elsif node.score == score
      depth
    elsif node.score > score
      depth_of(score, node.left, depth + 1)
    else
      depth_of(score, node.right, depth + 1)
    end
  end

  def min(node = @root)
    if !node.left.nil?
      min(node.left)
    else
      node.score
    end
  end

  def max(node = @root)
    if !node.right.nil?
      max(node.right)
    else
      node.score
    end
  end

  def sort
    if @root.nil?
      nil
    else
      sorted_array = []
      sorted_array_of_movies = sort_recursion(@root, sorted_array)
      sorted_array_of_movies
    end
  end

  def sort_recursion(node, array)
    if node.left.nil?
      array << node.score
    else
      sort_recursion(node.left, array)
      array << node.score
    end
    sort_recursion(node.right, array) unless node.right.nil?
    array
  end

  def load(file)
    movies_loaded_count = 0
    array_of_movie_lines = File.readlines(file)
    array_of_movie_lines.each do |movie|
      movie_line_array = movie.split(',')
      next if include?(movie_line_array[0].to_i)

      movies_loaded_count += 1
      insert(movie_line_array[0].to_i)
    end
    movies_loaded_count
  end

  def health(depth, node = @root, health_array = [])
    return nil if node.nil?

    if depth_of(node.score) == depth
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
    return 0 if node.nil?

    left_children = count_children_nodes(node.left)
    right_children = count_children_nodes(node.right)
    left_children + right_children + 1
  end

  def height(node = @root)
    if node.nil?
      -1
    else
      left_depth = height(node.left)
      right_depth = height(node.right)
      if left_depth > right_depth
        return left_depth + 1
      else
        return right_depth + 1
      end
    end
  end

  def leaves(node = @root)
    if node.nil?
      0
    elsif node.left.nil? && node.right.nil?
      1
    else
      left_leaves = leaves(node.left)
      right_leaves = leaves(node.right)
      left_leaves + right_leaves
    end
  end

  def delete(score, node = @root)
    if node.nil?
      return nil
    elsif node.score > score
      delete(score, node.left)
    elsif node.score < score
      delete(score, node.right)
    else
      if node.left.nil? && node.right.nil?
        nil
      elsif node.left.nil?
        node.right
      elsif node.right.nil?
        node.left
      else
        minimum_of_right_subtree = min(node.right)
        node.score = minimum_of_right_subtree
        delete(minimum_of_right_subtree, node.right)
      end
    end
    return score
  end
end

tree = BinarySearchTree.new

puts tree.insert(50)
puts tree.insert(60)
puts tree.insert(40)
puts tree.insert(70)
puts tree.insert(30)

puts tree.include?(50)
puts tree.include?(60)
puts tree.include?(40)
puts tree.include?(70)
puts tree.include?(30)
puts tree.include?(69)

puts tree.depth_of(50)
puts tree.depth_of(40)
puts tree.depth_of(60)
puts tree.depth_of(70)
puts tree.depth_of(30)

puts tree.min
puts tree.max

puts tree.leaves
puts tree.height

tree.sort

p tree.health(0)
p tree.health(1)
p tree.health(2)

puts tree.include?(50)
puts tree.delete(50)
puts tree.include?(50)

puts tree.include?(60)
puts tree.delete(60)
puts tree.include?(60)

puts tree.include?(40)
puts tree.delete(40)
puts tree.include?(40)

puts tree.include?(30)
puts tree.delete(30)
puts tree.include?(30)
