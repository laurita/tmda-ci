require "avl_tree"

NegInfinity = -1.0/0
def sort(list_to_sort, by_arg)
  list_to_sort.sort_by {|list| list[by_arg]}
end

def init_gt(g)
  gt = g.map {|list| list.first(list.length).push(NegInfinity).push("*")}
  gt.map {|list| list << AVLTree.new}
end

# gt=group table, row=tuple from original table, theta=list of join conditons
def lookup(gt, row, theta)
  lookup = []
  gt.each_with_index do |row_gt, index| 
    if theta.all? {|cond| row_gt[cond[0]] == row[cond[1]]}
      lookup.push(index)
    end
  end
  return lookup
end

def get_tree_from_gt(gt_i)
  gt_i.last
end

# now works only for the sum function, f is of the form [f_name, col_nr]
def result_tuple(gt_i, f)
  length = gt_i.length
  tree = get_tree_from_gt(gt_i)
  gt_te = gt_i[length - 2]
  gt_ts = gt_i[length - 3]
  final_sum = 0
  count = 0
  tree.entries.each do |entry|
    if entry[0] > gt_ts
      node_end = entry[0]
      entry[1].each do |value|
        if not value.empty?
          node_value_start = value[:start]
          row_sum = value[f[1]] * (gt_te - gt_ts + 1) / (node_end - node_value_start + 1)
          final_sum += row_sum
          count += 1 
        end
      end
    end
  end
  if count != 0
    if f[0] == "sum"
      result_tuple = gt_i.first(length-1).push(final_sum)
    elsif f[0] == "count"
      result_tuple = gt_i.first(length-1).push(count)
    elsif f[0] == "avg"
      result_tuple = gt_i.first(length-1).push(final_sum / count)
    end
  else
    result_tuple = nil
  end
  result_tuple 
end

def tmdi_ci(g,r,f,theta)
  z = []
  gt = init_gt(g)
  r_nr_columns = r[0].length
  r_ts = r_nr_columns - 2
  r_te = r_nr_columns - 1
  gt_nr_columns = gt[0].length
  gt_ts = gt_nr_columns - 3
  gt_te = gt_nr_columns - 2
  # sorted_r is r sorted by TS
  sorted_r = sort(r, r_ts)
  sorted_r.each do |row|
    lookup(gt, row, theta).each do |i|
      if row[r_ts] > gt[i][gt_ts]
        # insert a new node with time r.ts - 1 if not already there
        if not get_tree_from_gt(gt[i]).has_key?(row[r_ts] - 1)
          get_tree_from_gt(gt[i])[row[r_ts] - 1] = [{}]
        end
        # select the nodes that have the end point smaller than the start of a new row
        nodes_to_close = get_tree_from_gt(gt[i]).select {|x| x[0] < row[r_ts]}
        # CLOSE NODES 
        nodes_to_close.each do |v|
          gt[i][gt_te] = v[0]
          result_tuple = result_tuple(gt[i], f)
          if result_tuple != nil
            z << result_tuple
          end
          gt[i][gt_ts] = v[0] + 1
          gt[i][gt_te] = "*"
          get_tree_from_gt(gt[i]).delete(v[0])
        end
      end
      # INSERT NODE
      # if the end point of the row interval is alreday in a tree, append the row to the existing node value 
      if get_tree_from_gt(gt[i]).has_key?(row[r_te])
        get_tree_from_gt(gt[i])[row[r_te]] << {f[1] => row[f[1]], :start => (row[r_ts])}
      # if not, then insert a new node to the tree
      else
        get_tree_from_gt(gt[i])[row[r_te]] = [{f[1] => row[f[1]], :start => (row[r_ts])}]
      end
    end
  end
  # POSTPROCESSING: CLOSE THE REMAINING NODES
  gt.each do |gt_row|
    get_tree_from_gt(gt_row).sort_by {|entry| entry[0]}.each do |v|
      gt_row[gt_te] = v[0]
      z << result_tuple(gt_row, f)
      gt_row[gt_ts] = v[0] + 1
      gt_row[gt_te] = "*"
      get_tree_from_gt(gt_row).delete(v[0])
    end
  end
  z
end


=begin
require 'sqlite3'
db = SQLite3::Database.open('data/tsd.db')
r = db.execute("select * from employee where name = 0")
g = [[0]]
#g = [[0], [1], [2], [3], [4], [5], [6], [7], [8], [9]]
=end
g = [[1], [2]]
r = [[1, 2400, 1, 15], [1, 600, 19, 21], [1, 500, 1, 5], [1, 1000, 6, 15], [1, 600, 13, 24], [1, 400, 1, 10], [2, 1200, 4, 10], [2, 900, 13, 18]]
f = ["count",1]
theta=[[0,0]]
puts tmdi_ci(g,r,f,theta).inspect


























