require './lib/binary_search_tree.rb'

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

end
