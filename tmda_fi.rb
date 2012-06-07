require "avl_tree"

NegInfinity = -1.0/0

def tmda_fi(g,r,f,theta,c)
  gt = init_gt_fi(g)
  index = create_index(gt)
  r.each do |tuple|
    index_lookup(index,tuple,theta).each do |i|
      gt[i] = adjust(tuple,gt[i],f,c)
    end  
  end
  gt
end

# HELPERS:

def adjust(tuple, gt_i, f, c)
  gt_start = gt_i.length - 3
  gt_end = gt_i.length - 2
  if (c == "m")
    start = [gt_i[gt_start], tuple[tuple.length - 2]].max
    finish = [gt_i[gt_end], tuple.last].min
    if f[0] ==  "sum"
      gt_i[gt_i.length - 1] += tuple[f[1]] * (finish - start + 1) / (tuple.last - tuple[tuple.length - 2] + 1)
    elsif f[0] == "count"
      gt_i[gt_i.length - 1] += (finish - start + 1) / (tuple.last - tuple[tuple.length - 2] + 1)
    end
  elsif (c == "c")
    if f[0] == "sum"
      gt_i[gt_i.length - 1] += tuple[f[1]]
    elsif f[0] == "count"
      gt_i[gt_i.length - 1] += 1
    end
  end
  gt_i
end

def create_index(gt)
  index = AVLTree.new
  gt.each_with_index do |row, i|
    index[row] = i
  end
  index
end

def index_lookup(index, tuple, theta)
  indexes = []
  index.find_all{|node| theta.all? {|cond| node[0][cond[0]] == tuple[cond[1]]} and node[0][1]  <= tuple.last and node[0][2] >= tuple[tuple.length - 2]}.collect{|x| x[1]}
end

def init_gt_fi(g)
  gt = []
  g.each do |x|
    # list = [join attribute, start, end, function value]
    list = [x[0], x[1], x[2], 0]
    gt.push(list)
  end
  gt
end

#=begin
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
#=end
=begin
def lookup_fi(gt, tuple, theta)
  indexes = []
  gt_start = gt[0].length - 3
  gt_end = gt[0].length - 2 
  indexes = (0...gt.size).select{|i| theta.all? {|cond| gt[i][cond[0]] == tuple[cond[1]]} and (gt[i][gt_start] <= tuple.last) and (gt[i][gt_end] >= tuple[tuple.length - 2])}
  return indexes
end
=end