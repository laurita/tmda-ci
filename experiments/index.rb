require "avl_tree"
require 'sqlite3'

def create_index(gt)
  index = AVLTree.new
  gt.each_with_index do |row, i|
    index[row] = i
  end
  index
end

def index_lookup(index, tuple, theta)
  indexes = []
  index.find_all{|node| theta.all? {|cond| node[0][cond[0]] == tuple[cond[1]]} and node[0][1]  <= tuple.last and node[0][2] >= tuple[tuple.length - 2]}
end
  
end
def lookup_fi(gt, tuple, theta)
  lookup = []
  gt_start = gt[0].length - 3
  gt_end = gt[0].length - 2 
  gt.each_with_index do |row_gt, index| 
    if (theta.all? {|cond| row_gt[cond[0]] == tuple[cond[1]]} and (row_gt[gt_start] <= tuple.last) and (row_gt[gt_end] >= tuple[tuple.length - 2]))
      lookup.push(index)
    end
  end
  return lookup
end

db = SQLite3::Database.open('data/tsd.db')
g = db.execute("select * FROM groups_200000;")

index = create_index(g)
