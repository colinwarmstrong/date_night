class Node

  attr_accessor :score,
                :left,
                :right

  def initialize(score)
    @score = score
  end

  # def insert_node(node, score, depth)
  #   if node.score > score
  #     if node.left == nil
  #       node.left = Node.new(score)
  #       return depth
  #     else
  #       depth += 1
  #       insert_node(node.left, score, depth)
  #     end
  #   elsif node.score < score
  #     if node.right == nil
  #       node.right = Node.new(score)
  #       return depth
  #     else
  #       depth += 1
  #       insert_node(node.right, score, depth)
  #     end
  #   end
  # end

end
