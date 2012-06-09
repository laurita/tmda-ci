$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sqlite3'
require 'tmda_fi'

db_name = 'data/tsd.db'
file_name = 'seq_010'

def make_group_table(g, r, number_of_groups)
  number_of_intervals_in_group = number_of_groups / g.length
  subintervals = []
  #interval_end = r.max_by {|x| x[x.length - 1]}.last
  #interval_start = r.min_by {|x| x[x.length - 2]}.last(2)[0]
  #interval_length = interval_end - interval_start + 1
  #subinterval_length = (interval_length.to_f / number_of_intervals_in_group).ceil
  subinterval_length = (2399.to_f / number_of_intervals_in_group).ceil
  #range = Range.new(interval_start, interval_end)
  range = Range.new(0, 2399)
  range.step(subinterval_length) {|x| subintervals.push([x, x + subinterval_length - 1])}
  groups = g.map {|x| subintervals.map {|y| [x, y].flatten }}.flatten(1)
  groups
end

def load_group_table(db, groups_table, result_size)
  db.execute("DROP TABLE IF EXISTS groups_#{result_size};")
  db.execute("CREATE TABLE groups_#{result_size}(name int, TS int, TE int);")
  groups_table.each do |row|
    db.execute("INSERT INTO groups_#{result_size} values ( ?, ?, ? )", row[0], row[1], row[2])
  end
end

def create_group_tables(int_start, int_end)
  db = SQLite3::Database.open('data/tsd.db')
  g = db.execute("select DISTINCT name FROM random_02;")
  number_of_groups = [20, 40, 60, 80, 100]
  number_of_intervals_in_group = number_of_groups.map {|number| number / 10}
  subintervals = []
  int_length = int_end - int_start + 1
  number_of_intervals_in_group.each do |number|
    subinterval_length = (int_length.to_f / number).ceil
    range = Range.new(int_start, int_end)
    range.step(subinterval_length) {|x| subintervals.push([x, x + subinterval_length - 1])}
    groups = g.map {|x| subintervals.map {|y| [x, y].flatten }}.flatten(1)
    db.execute("DROP TABLE IF EXISTS groups_#{number * 10};")
    db.execute("CREATE TABLE groups_#{number * 10}(name int, TS int, TE int);")
    groups.each do |row|
      db.execute("INSERT INTO groups_#{number * 10} values ( ?, ?, ? )", row[0], row[1], row[2])
    end
  end
end

def runtimetest()
  db = SQLite3::Database.open('data/tsd.db')
  f = ["sum", 1]
  theta = [0, 0]
  c = "c"
  if c == "m"
    puts "CONSTANT ATTRIBUTES"
  elsif c == "m"
    puts "MALLABLE ATTRIBUTES"
  end
  number_of_groups = [200000, 400000, 600000, 800000, 1000000]
  data_size = [2, 4, 6, 8, 10]
  #data_type = ["equal", "seq", "random", "worst"]
  data_type = ["random"]
  times = {}
  number_of_groups.each do |number|
    puts "Number of tuples(groups): #{number}"
    times[number] = {}
    data_type.each do |type| 
      times[number][type] = {}
      puts "Runtime test for #{type} data:"
      data_size.each do |i| 
        r = db.execute("select * from #{type}_0#{i};")
        g = db.execute("select DISTINCT name FROM #{type}_0#{i};")
        groups = make_group_table(g, r, number)
        load_group_table(db, groups, type, number)
        size = 100000 * i
        puts "Testing for size #{size}..."
        start_time = Time.now
        tmda_fi(groups,r,f,theta,c).inspect
        duration = Time.now - start_time
        times[number][type][size] = duration
        puts "TMDA-FI took #{duration} seconds with data of #{size}"
      end
    end
    times
  end
end

#puts runtimetest().inspect
#=begin
db = SQLite3::Database.open('data/tsd.db')
create_group_tables(0, 2399)
f = ["sum", 1]
theta = [0, 0]
c = "c"
data_size = [2, 4, 6, 8, 10]
#data_size = [2]
data_type = "random"
number_of_groups = [20, 40, 60, 80, 100]
g = db.execute("select DISTINCT name FROM #{data_type}_02;")
data_size.each do |data_size|
  size = data_size * 100000
  puts "Testing for size #{size}..."
  number_of_groups.each do |number|
    puts "Number of result tuples: #{number}"
    r = db.execute("select * from #{data_type}_0#{data_size};")
    groups = make_group_table(g, r, number)  
    #load_group_table(db, groups, number_of_groups)
    start_time = Time.now
    tmda_fi(groups,r,f,theta,c).inspect
    duration = Time.now - start_time
    puts "TMDA-FI took #{duration} seconds with data of #{size} and #{number} result tuples."
  end
end
#=end

#create_group_tables()