require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree.rb'

class BinarySearchTreeTest < Minitest::Test

  def test_if_binary_search_trees_exist
    tree = BinarySeachTree.new
    assert_instance_of BinarySearchTree, tree
  end

end
