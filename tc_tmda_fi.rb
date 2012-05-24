$LOAD_PATH.unshift File.dirname(__FILE__)

require "tmda_fi"
require "test/unit"
require "avl_tree"

class TestTsd < Test::Unit::TestCase

  def test_lookup_fi
    tuple1 = [1, 2400, 1, 15]
    tuple2 = [1, 500, 1, 5]
    gt = [
          {:attr=>1, :start=>1, :end=>12, :function=>0}, 
          {:attr=>1, :start=>13, :end=>24, :function=>0}, 
          {:attr=>2, :start=>1, :end=>12, :function=>0}, 
          {:attr=>2, :start=>13, :end=>24, :function=>0}
         ]
    theta = [{:r_col_nr => 0, :gt_attr_name => :attr}]
    looked_up_rows1 = [0, 1]
    looked_up_rows2 = [0] 
    assert_equal(looked_up_rows1, lookup_fi(gt, tuple1, theta))
    assert_equal(looked_up_rows2, lookup_fi(gt, tuple2, theta))
  end
  
  def test_init_gt_fi
    g = [[1, 1, 12], [1, 13, 24], [2, 1, 12], [2, 13, 24]]
    gt = [{:attr=>1, :start=>1, :end=>12, :function=>0}, 
          {:attr=>1, :start=>13, :end=>24, :function=>0}, 
          {:attr=>2, :start=>1, :end=>12, :function=>0}, 
          {:attr=>2, :start=>13, :end=>24, :function=>0}]
    assert_equal(gt, init_gt_fi(g))
  end
  
  def test_adjust
    tuple = [1, 2400, 1, 15]
    gt_i = {:attr=>1, :start=>1, :end=>12, :function=>0}
    c = "m"
    r_prime = {:attr=>1, :start=>1, :end=>12, :function=>1920}
    assert_equal(r_prime, adjust(tuple, gt_i, c))
  end
  
  def test_tmda_fi
    g = [[1, 1, 12], [1, 13, 24], [2, 1, 12], [2, 13, 24]]
    r = [
         [1, 2400, 1, 15], [1, 600, 19, 21], [1, 500, 1, 5], [1, 1000, 6, 15],
         [1, 600, 13, 24], [1, 400, 1, 10], [2, 1200, 4, 10], [2, 900, 13, 18]
        ]
    f = "sum"
    theta = [{:r_col_nr => 0, :gt_attr_name => :attr}]
    c = "m"
    result = [
              {:attr=>1, :start=>1, :end=>12, :function=>3520},
              {:attr=>1, :start=>13, :end=>24, :function=>1980},
              {:attr=>2, :start=>1, :end=>12, :function=>1200},
              {:attr=>2, :start=>13, :end=>24, :function=>900}
             ]
    assert_equal(result, tmda_fi(g,r,f,theta,c))
  end
end