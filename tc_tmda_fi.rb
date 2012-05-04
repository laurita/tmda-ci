$LOAD_PATH.unshift File.dirname(__FILE__)

require "tmda_fi"
require "test/unit"
require "avl_tree"

class TestTsd < Test::Unit::TestCase

  def test_lookup_fi
    r = [3,421,362,789]
    gt = [{:attr => 0, :start => 1, :end => 4},{:attr => 1, :start => 300, :end => 700}, {:attr => 3, :start => 29, :end => 400},
          {:attr => 4, :start => 500, :end => 539},{:attr => 3, :start => 1, :end => 4}, {:attr => 3, :start => 365, :end => 700}]
    theta = [[0,0]]
    looked_up_rows = [2, 5] 
    assert_equal(looked_up_rows, lookup_fi(gt, r, theta))
  end
  
end