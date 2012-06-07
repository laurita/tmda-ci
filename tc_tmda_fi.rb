$LOAD_PATH.unshift File.dirname(__FILE__)

require "tmda_fi"
require "test/unit"
require "avl_tree"

class TestTsd < Test::Unit::TestCase

  def test_lookup_fi
    tuple1 = [1, 2400, 1, 15]
    tuple2 = [1, 500, 1, 5]
    gt = [[1, 1, 12, 0], [1, 13, 24, 0], [2, 1, 12, 0], [2, 13, 24, 0]]
    theta = [0, 0]
    looked_up_rows1 = [0, 1]
    looked_up_rows2 = [0] 
    assert_equal(looked_up_rows1, lookup_fi(gt, tuple1, theta))
    assert_equal(looked_up_rows2, lookup_fi(gt, tuple2, theta))
  end
  
  def test_init_gt_fi
    g = [[1, 1, 12], [1, 13, 24], [2, 1, 12], [2, 13, 24]]
    gt = [[1, 1, 12, 0], [1, 13, 24, 0], [2, 1, 12, 0], [2, 13, 24, 0]]
    assert_equal(gt, init_gt_fi(g))
  end
  
  def test_adjust
    tuple = [1, 2400, 1, 15]
    gt_i = [1, 1, 12, 0]
    c = "m"
    f = ["sum", 1]
    r_prime = [1, 1, 12, 1920]
    assert_equal(r_prime, adjust(tuple, gt_i, f, c))
  end
  
  def test_tmda_fi
    g = [[1, 1, 12], [1, 13, 24], [2, 1, 12], [2, 13, 24]]
    r = [
         [1, 2400, 1, 15], [1, 600, 19, 21], [1, 500, 1, 5], [1, 1000, 6, 15],
         [1, 600, 13, 24], [1, 400, 1, 10], [2, 1200, 4, 10], [2, 900, 13, 18]
        ]
    f = ["sum", 1]
    theta = [0, 0]
    c = "m"
    result = [[1, 1, 12, 3520], [1, 13, 24, 1980], [2, 1, 12, 1200], [2, 13, 24, 900]]
    assert_equal(result, tmda_fi(g,r,f,theta,c))
  end
end