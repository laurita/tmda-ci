require "avl_tree"

NegInfinity = -1.0/0

def init_gt_fi(g)
  gt = []
  g.each do |x|
    hash = {:attr => x[0], :start => x[1], :end => x[2], :function => 0}
    gt << hash
  end
end

def lookup_fi(gt,r,theta)
  puts "gt: #{gt}"
  puts "r: #{r}"
  puts "theta: #{theta}"
  lookup = []
  gt.each_with_index do |row_gt, index| 
    puts "row_gt: #{row_gt}"
    if (theta.all? {|cond| row_gt[cond[:gt_attr_name]] == r[cond[:r_col_nr]]} and (row_gt[:start] <= r.last) and (gt[:end] >= (r.last - 1)))
      lookup.push(index)
    end
  end
  return lookup
end

def tmda_fi(g,r,f,theta,c)
  gt = init_gt_fi(g)
  r.each do |row|
    lookup_fi(gt,row,theta).each do |i|
      r_prime = adjust(row,gt[i],c)
      gt[i][]
    end  
  end
end

r = [3,421,362,789]
gt = [{:attr => 0, :start => 1, :end => 4},{:attr => 1, :start => 300, :end => 700}, {:attr => 3, :start => 29, :end => 400},
      {:attr => 4, :start => 500, :end => 539},{:attr => 3, :start => 1, :end => 4}, {:attr => 3, :start => 365, :end => 700}]
theta = [{:r_col_nr => 0, :gt_attr_name => :attr}]
looked_up_rows = [2, 5]
puts lookup_fi(gt, r, theta).inspect