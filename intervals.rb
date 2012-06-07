require 'sqlite3'

db = SQLite3::Database.open('data/tsd.db')
r = db.execute("select * from random_010;")
g = db.execute("select DISTINCT name FROM random_010;")
number_of_groups = 200

def make_group_table(g, r, number_of_groups)
  number_of_intervals_in_group = (number_of_groups / g.length.to_f)
  subintervals = []
  interval_end = r.max_by {|x| x[x.length - 1]}.last
  interval_start = r.min_by {|x| x[x.length - 2]}.last(2)[0]
  interval_length = interval_end - interval_start + 1
  subinterval_length = interval_length / number_of_intervals_in_group
  range = Range.new(interval_start, interval_end)
  range.step(subinterval_length) {|x| subintervals.push([x, x + subinterval_length - 1])}
  subintervals.inspect
end

result = make_group_table(g, r, number_of_groups)
puts result.inspect
puts result.length