# running tests
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sqlite3'
require 'tsd'
require 'tmda_fi'

def runtimetest()
  db = SQLite3::Database.open('data/tsd.db')
  g = [[0], [1], [2], [3], [4], [5], [6], [7], [8], [9]]
  f = ["sum",1]
  theta=[[0,0]]
  c = "c"
  if c == "c"
    puts "CONSTANT ATTRIBUTES"
  elsif c == "m"
    puts "MALLABLE ATTRIBUTES"
  end
  #data_size = [2, 4, 6, 8, 10]
  data_size = [10]
  #data_type = ["equal", "seq", "random", "worst"]
  data_type = ["worst"]
  times = {}
  data_type.each do |type| 
    times[type] = {}
    puts "Runtime test for #{type} data:"
    data_size.each do |i| 
      r = db.execute("select * from #{type}_0#{i};")
      size = 100000 * i
      puts "Testing for size #{size}..."
      start_time = Time.now
      tmda_ci_new(g,r,f,theta,c).inspect
      duration = Time.now - start_time
      times[type][size] = duration
      puts "TMDA-CI took #{duration} seconds with data of #{size}"
    end
  end
  times
end

=begin
def runtimetest()
  db = SQLite3::Database.open('data/tsd.db')
  g = [[0, 1, 500], [0, 501, 1000], [1, 1, 500], [1, 501, 1000], 
       [2, 1, 500], [2, 501, 1000], [3, 1, 500], [3, 501, 1000], 
       [4, 1, 500], [4, 501, 1000], [5, 1, 500], [5, 501, 1000], 
       [6, 1, 500], [6, 501, 1000], [7, 1, 500], [7, 501, 1000], 
       [8, 1, 500], [8, 501, 1000], [9, 1, 500], [9, 501, 1000]]
  f = "sum"
  theta = [{:r_col_nr => 0, :gt_attr_name => :attr}]
  c = "c"
  if c == "m"
    puts "CONSTANT ATTRIBUTES"
  elsif c == "m"
    puts "MALLABLE ATTRIBUTES"
  end
  data_size = [2, 4, 6, 8, 10]
  data_type = ["equal", "seq", "random", "worst"]
  times = {}
  data_type.each do |type| 
    times[type] = {}
    puts "Runtime test for #{type} data:"
    data_size.each do |i| 
      r = db.execute("select * from #{type}_0#{i};")
      size = 100000 * i
      puts "Testing for size #{size}..."
      start_time = Time.now
      tmda_fi(g,r,f,theta,c).inspect
      duration = Time.now - start_time
      times[type][size] = duration
      puts "TMDA-FI took #{duration} seconds with data of #{size}"
    end
  end
  times
end
=end
puts runtimetest()