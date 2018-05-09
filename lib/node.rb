class Node

  attr_accessor :score, :left, :right

  def initialize(score)
    @score = score
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
