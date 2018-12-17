require 'minitest/autorun'
require 'minitest/pride'
require './lib/node.rb'

class NodeTest < Minitest::Test
  def test_if_nodes_exist
    n = Node.new(50)
    assert_instance_of Node, n
  end

  def test_if_nodes_set_scores_when_initialized
    n1 = Node.new(20)
    n2 = Node.new(50)
    n3 = Node.new(70)
    assert_equal 20, n1.score
    assert_equal 50, n2.score
    assert_equal 70, n3.score
  end

  def test_if_initialized_right_and_left_nodes_are_nil
    node = Node.new(50)
    assert_nil node.left
    assert_nil node.right
  end
end
