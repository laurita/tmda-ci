# running tests
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sqlite3'
require 'tsd'

def runtimetest()
  db = SQLite3::Database.open('data/tsd.db')
  g = [[0], [1], [2], [3], [4], [5], [6], [7], [8], [9]]
  f = ["sum",1]
  theta=[[0,0]]
  c="c"
  if c == "c"
    puts "CONSTANT ATTRIBUTES"
  elsif c == "m"
    puts "MALLABLE ATTRIBUTES"
  end
  data_size = [2, 4, 6, 8, 10]
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
      puts "TMDA-CI took #{duration} time with data of #{size}"
    end
  end
  times
end

puts runtimetest()