

def test()
  db = SQLite3::Database.open('data/tsd.db')
  r = db.execute("select * from random_02;")
  g = [[0], [1], [2], [3], [4], [5], [6], [7], [8], [9]]
  #g = [[1], [2]]
  #r = [[1, 2400, 1, 15], [1, 600, 19, 21], [1, 500, 1, 5], [1, 1000, 6, 15], [1, 600, 13, 24], [1, 400, 1, 10], [2, 1200, 4, 10], [2, 900, 13, 18]]
  f = ["sum",1]
  theta = [[0,0]]
  c = "c"
  puts tmda_ci(g,r,f,theta,c).inspect 
end

#main()


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