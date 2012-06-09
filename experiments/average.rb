require 'sqlite3'

db = SQLite3::Database.open('data/tsd.db')
sum = 0
open = []
(0..2398).each do |i|
  puts "i: #{i}"
  x = db.execute("select count(*) from random_02 where TS <= #{i} and TE >= #{i};")[0][0]
  puts "open tuples: #{x}"
  open.push(x)
  sum += x
  puts "sum: #{sum}"
end
avg = sum / 2399
puts avg

open_rare = []
open.each_with_index do |x, i| 
  if (i % 10 == 1) then 
    open_rare.push(x)
  end
end