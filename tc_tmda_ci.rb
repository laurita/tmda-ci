$LOAD_PATH.unshift File.dirname(__FILE__)

require "tmda_ci"
require "test/unit"
require "avl_tree"

class TestTsd < Test::Unit::TestCase
 
  def test_sort
    list_to_sort = [[4,1,2], [7,8,9], [3,2,1]]
    sorted_list_by_0 = [[3,2,1], [4,1,2], [7,8,9]]
    sorted_list_by_1 = [[4,1,2], [3,2,1], [7,8,9]]
    sorted_list_by_2 = [[3,2,1], [4,1,2], [7,8,9]]
    assert_equal(sorted_list_by_0, sort(list_to_sort, 0))
    assert_equal(sorted_list_by_1, sort(list_to_sort, 1))
    assert_equal(sorted_list_by_2, sort(list_to_sort, 2))
  end

  def test_init_gt
    g = [[1,1],[1,2],[2,1],[2,2]]
    gt_without_trees = [[1,1,NegInfinity,"*"],[1,2,NegInfinity,"*"],[2,1,NegInfinity,"*"],[2,2,NegInfinity,"*"]]
    # assert equal gt without trees
    gt = init_gt(g)
    assert_equal(gt_without_trees, gt.map {|list| list.first(list.length-1)})
    # assert all trees in gt are empty
    assert_block do
      gt.all? {|list| list[list.length-1].empty?}
    end
  end
  
  def test_lookup
    r = [3,421,362,789]
    gt = [[0,nil,nil],[1,nil,nil],[2,nil,nil],[3,nil,nil],[4,nil,nil],[3,nil,nil]]
    theta = [[0,0]]
    looked_up_rows = [3,5] 
    assert_equal(looked_up_rows, lookup(gt, r, theta))
  end
  
  def test_result_tuple
    tree = AVLTree.new
    tree[15] = [{1 => 2400, :start => 1}]
    tree.set_count(1)
    tree.set_sum(2400)
    tree[5] = [{1 => 500, :start => 1}]
    tree.set_count(tree.get_count + 1)
    tree.set_sum(tree.get_sum + 500)
    tree[10] = [{1 => 400, :start => 1}]
    tree.set_count(tree.get_count + 1)
    tree.set_sum(tree.get_sum + 400)
    gt_i = [1, 1, 5, tree]
    f = ["sum", 1]
    res_tuple = [1, 1, 5, 3300]
    assert_equal(res_tuple, result_tuple(gt_i,f,"c"))
    res_tuple = [1, 1, 5, 1500]
    assert_equal(res_tuple, result_tuple(gt_i,f,"m"))
  end
  
  def test_get_tree_from_gt
    tree = AVLTree.new
    gt_i = [1, 2, 3, tree]
    assert_equal(tree, get_tree_from_gt(gt_i))
  end
=begin
  def test_tmda_ci
    g = [[1], [2]]
    r = [[1, 2400, 1, 15], [1, 600, 19, 21], [1, 500, 1, 5], [1, 1000, 6, 15], [1, 600, 13, 24], [1, 400, 1, 10], [2, 1200, 4, 10], [2, 900, 13, 18]]
    f = ["count",1]
    theta=[[0,0]]
    c = "m"
    result = 
=end
end