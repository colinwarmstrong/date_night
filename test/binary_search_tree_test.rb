require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree.rb'

class BinarySearchTreeTest < Minitest::Test
  def test_if_binary_search_trees_exist
    tree = BinarySearchTree.new
    assert_instance_of BinarySearchTree, tree
  end

  def test_if_insert_inserts_node
    tree = BinarySearchTree.new
    tree.insert(50)
    assert tree.include?(50)
  end

  def test_if_include_searches_tree_until_match
    tree = BinarySearchTree.new
    tree.insert(50)
    tree.insert(70)
    tree.insert(60)
    tree.insert(80)
    assert tree.include?(50)
    refute tree.include?(90)
    assert tree.include?(80)
    refute tree.include?(-22)
  end

  def test_if_depth_of_returns_accurate_depth
    tree = BinarySearchTree.new
    tree.insert(50)
    tree.insert(70)
    tree.insert(60)
    tree.insert(80)
    assert_equal 0, tree.depth_of(50)
    assert_equal 1, tree.depth_of(70)
    assert_equal 2, tree.depth_of(60)
    assert_equal 2, tree.depth_of(80)
  end

  def test_if_min_returns_smallest_value
    tree = BinarySearchTree.new
    tree.insert(50)
    tree.insert(40)
    tree.insert(30)
    tree.insert(20)
    minimum_value = tree.min
    assert_equal 20, minimum_value
  end

  def test_if_max_returns_largest_value
    tree = BinarySearchTree.new
    tree.insert(50)
    tree.insert(60)
    tree.insert(70)
    tree.insert(80)
    maximum_value = tree.max
    assert_equal 80, maximum_value
  end

  def test_if_sort_returns_sorted_array
    tree = BinarySearchTree.new
    tree.insert(50)
    tree.insert(60)
    tree.insert(40)
    sorted_array = tree.sort
    assert sorted_array[0] < sorted_array[1]
    assert sorted_array[1] < sorted_array[2]
    assert_equal 60, sorted_array[2]
  end

  def test_load_inserts_movies_from_file
    tree = BinarySearchTree.new
    tree.load('./movies.txt')
    assert tree.include?(50)
    assert tree.include?(0)
    assert tree.include?(100)
  end

  def test_if_height_is_accurate
    tree = BinarySearchTree.new
    tree.insert(50)
    assert_equal tree.height, 0
    tree.insert(60)
    assert_equal tree.height, 1
    tree.insert(70)
    assert_equal tree.height, 2
  end

  def test_if_leaves_count_is_accurate
    tree = BinarySearchTree.new
    tree.insert(50)
    tree.insert(60)
    tree.insert(40)
    leaves = tree.leaves
    assert_equal 2, leaves
  end

  def test_if_delete_works_properly
    tree = BinarySearchTree.new
    tree.insert(50)
    tree.insert(60)
    tree.insert(40)
    assert tree.include?(40)
    tree.delete(40)
    assert tree.include?(40)
  end

  def test_if_health_works_at_zero_depth
    tree = BinarySearchTree.new
    tree.insert(50)
    depth_zero_health = tree.health(0)
    assert_equal depth_zero_health, [[50, 1, 100]]
  end

  def test_if_count_children_nodes_is_accurate
    tree = BinarySearchTree.new
    tree.insert(50)
    tree.insert(60)
    tree.insert(40)
    assert_equal tree.count_children_nodes, 3
  end
end
