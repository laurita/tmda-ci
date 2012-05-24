require "avl_tree"

NegInfinity = -1.0/0

def init_gt_fi(g)
  gt = []
  g.each do |x|
    hash = {:attr => x[0], :start => x[1], :end => x[2], :function => 0}
    gt << hash
  end
  gt
end

def lookup_fi(gt, tuple, theta)
  lookup = []
  gt.each_with_index do |row_gt, index| 
    if (theta.all? {|cond| row_gt[cond[:gt_attr_name]] == tuple[cond[:r_col_nr]]} and (row_gt[:start] <= tuple.last) and (row_gt[:end] >= tuple[tuple.length - 2]))
      lookup.push(index)
    end
  end
  return lookup
end

def adjust(tuple, gt_i, theta)
  #puts "tuple: #{tuple.inspect}"
  start = [gt_i[:start], tuple[tuple.length - 2]].max
  #puts "start: #{start}"
  finish = [gt_i[:end], tuple.last].min
  #puts "finish: #{finish}"
  gt_i[:function] += tuple[1] * (finish - start + 1) / (tuple.last - tuple[tuple.length - 2] + 1)
  gt_i
end

def tmda_fi(g,r,f,theta,c)
  gt = init_gt_fi(g)
  puts "gt: #{gt.inspect}"
  r.each do |tuple|
    puts "tuple: #{tuple}"
    lookup_fi(gt,tuple,theta).each do |i|
      gt[i] = adjust(tuple,gt[i],c)
      puts gt[i].inspect
    end  
  end
  gt
end