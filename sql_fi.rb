$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sqlite3'
require 'tmda_fi'
require 'tmda_ci'

=begin
db = SQLite3::Database.open('data/tsd.db')
f = ["sum", 1]
theta = [0, 0]
c = "c"
data_size = [200, 400, 600, 800, 1000]
data_type = "random"
data_size.each do |size|
  puts "Testing for size #{size}..."
  table = "#{data_type}_#{size}"
  r = db.execute("select * from #{table};")
  puts "Computing constant intervals..."
  start_time = Time.now
  sql = "select a.name, a.TS, min(b.TE)
  from (select r1.name, TS from (select name from #{table}) as r1, (select name, TS from #{table}) as r2 where r1.name <> r2.name
        union
        select r1.name,  TS from (select name from #{table}) as r1, (select name, TE+1 as TS from #{table}) as r2 where r1.name <> r2.name
       ) as a,
       (select r1.name, TE from (select name from #{table}) as r1, (select name, TE from #{table}) as r2 where r1.name <> r2.name
        union
        select r1.name, TE from (select name from #{table}) as r1, (select name, TS-1 as TE from #{table}) as r2 where r1.name <> r2.name
       ) as b
  where a.name = b.name
  and a.TS < b.TE
  and exists (select * from #{table} where #{table}.name <> a.name and #{table}.TS <= a.TS and a.TS <= #{table}.TS)
  group by a.name, a.TS;"
  groups = db.execute(sql)  
  interval_duration = Time.now - start_time
  puts "Interval computation took #{interval_duration} seconds."
  start_time = Time.now
  tmda_fi(groups,r,f,theta,c).inspect
  duration = Time.now - start_time
  puts "TMDA-FI took #{duration} seconds with data of #{size}."
  puts "CI-SQL + TMDA-FI tool #{interval_duration + duration} seconds."
end
=end
db = SQLite3::Database.open('data/tsd.db')
f = ["sum", 1]
theta = [0, 0]
c = "c"
data_size = [200, 400, 600, 800, 1000]
data_type = "random"
g = db.execute("SELECT DISTINCT name FROM random_200;")
data_size.each do |size|
  puts "Testing for size #{size}..."
  table = "#{data_type}_#{size}"
  r = db.execute("select * from #{table};")
  start_time = Time.now
  tmda_ci(g,r,f,theta,c).inspect
  duration = Time.now - start_time
  puts "TMDA-CI took #{duration} seconds with data of #{size}."
end