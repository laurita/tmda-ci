require "avl_tree"

NegInfinity = -1.0/0

def init_gt_fi(g)
  gt = []
  g.each do |x|
    # list = [join attribute, start, end, function value]
    list = [x[0], x[1], x[2], 0]
    gt.push(list)
  end
  gt
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

def adjust(tuple, gt_i, f, c)
  gt_start = gt_i.length - 3
  gt_end = gt_i.length - 2
  if (c == "m")
    #puts "tuple: #{tuple.inspect}"
    start = [gt_i[gt_start], tuple[tuple.length - 2]].max
    #puts "start: #{start}"
    finish = [gt_i[gt_end], tuple.last].min
    #puts "finish: #{finish}"
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

def tmda_fi(g,r,f,theta,c)
  gt = init_gt_fi(g)
  #puts "gt: #{gt.inspect}"
  r.each do |tuple|
    #puts "tuple: #{tuple}"
    lookup_fi(gt,tuple,theta).each do |i|
      gt[i] = adjust(tuple,gt[i],f,c)
      #puts gt[i].inspect
    end  
  end
  gt
end

def make_group_table(g, r, number_of_groups)
  number_of_intervals_in_group = (number_of_groups / g.length)
  subintervals = []
  interval_end = r.max_by {|x| x[x.length - 1]}.last
  interval_start = r.min_by {|x| x[x.length - 2]}.last(2)[0]
  interval_length = interval_end - interval_start + 1
  subinterval_length = interval_length / number_of_intervals_in_group
  range = Range.new(interval_start, interval_end)
  range.step(subinterval_length) {|x| subintervals.push([x, x + subinterval_length - 1])}
  puts subintervals.inspect
end

# select .. => [[1], [2]]; N = 2; SELECT MIN, MAX = 1, 24; [1,12], [13,24] 
g = [[1, 1, 12], [1, 13, 24], [2, 1, 12], [2, 13, 24]]
r = [
     [1, 2400, 1, 15], [1, 600, 19, 21], [1, 500, 1, 5], [1, 1000, 6, 15],
     [1, 600, 13, 24], [1, 400, 1, 10], [2, 1200, 4, 10], [2, 900, 13, 18]
    ]
f = ["sum", 1]

theta = [0, 0]
c = "m"
puts tmda_fi(g,r,f,theta,c).inspect