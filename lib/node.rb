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

  def include_node?(node, score)
    if node == nil
      return false
    elsif node.score == score
      return true
    elsif node.score > score
      include_node?(node.left, score)
    else
      include_node?(node.right, score)
    end
  end

  def depth_of_node(node, score, depth)
    if node.score == score
      return depth
    elsif node == nil
      return nil
    elsif node.score > score
      depth_of_node(node.left, score, depth)
    else
      depth_of_node(node.right, score, depth)
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
