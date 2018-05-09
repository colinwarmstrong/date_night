require './lib/binary_search_tree.rb'

class Node

  attr_accessor :score,
                :left,
                :right

  def initialize(score)
    @score = score
    @right = nil
    @left = nil
  end

  def insert_node(node, score, depth)
    if node.score > score
      if node.left == nil
        node.left = Node.new(score)
        return depth
      else
        depth += 1
        node.insert_node(node.left, score, depth)
      end
    elsif node.score < score
      if node.right == nil
        node.right = Node.new(score)
        return depth
      else
        depth += 1
        node.insert_node(node.right, score, depth)
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
