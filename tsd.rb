require 'csv'

# reads file and makes array of arrays 
#x = CSV.read('/Users/laura/Sandbox/TSD_project/data/data-random-02', :col_sep => ';')
#x = x.map {|item| item.map {|item| item.to_i}}

x = [
	{'N' => 'Jan', 'CID' => 140, 'D' => 'DB', 'P' => 'P1', 'H' => 2400, 'S' => 1200, 'TS' => Date.new(2003, 1), 'TE' => Date.new(2004, 3)},
	{'N' => 'Jan', 'CID' => 163, 'D' => 'DB', 'P' => 'P1', 'H' => 600, 'S' => 1500, 'TS' => Date.new(2004, 7), 'TE' => Date.new(2004, 9)},
	{'N' => 'Ann', 'CID' => 141, 'D' => 'DB', 'P' => 'P2', 'H' => 500, 'S' => 700, 'TS' => Date.new(2003, 1), 'TE' => Date.new(2003, 5)},
	{'N' => 'Ann', 'CID' => 150, 'D' => 'DB', 'P' => 'P1', 'H' => 1000, 'S' => 800, 'TS' => Date.new(2003, 6), 'TE' => Date.new(2004, 3)},
	{'N' => 'Ann', 'CID' => 157, 'D' => 'DB', 'P' => 'P1', 'H' => 600, 'S' => 500, 'TS' => Date.new(2004, 1), 'TE' => Date.new(2004, 12)},
	{'N' => 'Sue', 'CID' => 142, 'D' => 'DB', 'P' => 'P2', 'H' => 400, 'S' => 800, 'TS' => Date.new(2003, 1), 'TE' => Date.new(2003, 10)},
	{'N' => 'Tom', 'CID' => 143, 'D' => 'AI', 'P' => 'P2', 'H' => 1200, 'S' => 2000, 'TS' => Date.new(2003, 4), 'TE' => Date.new(2003, 10)},
	{'N' => 'Tom', 'CID' => 153, 'D' => 'AI', 'P' => 'P1', 'H' => 900, 'S' => 1800, 'TS' => Date.new(2004, 1), 'TE' => Date.new(2004, 6)}
	]

x = [
	['Jan', 140, 'DB', 'P1', 2400, 1200, Date.new(2003, 1), Date.new(2004, 3)],
	['Jan', 163, 'DB', 'P1', 600, 1500, Date.new(2004, 7), Date.new(2004, 9)],
	['Ann', 141, 'DB', 'P2', 500, 700, Date.new(2003, 1), Date.new(2003, 5)],
	['Ann', 150, 'DB', 'P1', 1000, 800, Date.new(2003, 6), Date.new(2004, 3)],
	['Ann', 157, 'DB', 'P1', 600, 500, Date.new(2004, 1), Date.new(2004, 12)],
	['Sue', 142, 'DB', 'P2', 400, 800, Date.new(2003, 1), Date.new(2003, 10)],
	['Tom', 143, 'AI', 'P2', 1200, 2000, Date.new(2003, 4), Date.new(2003, 10)],
	['Tom', 153, 'AI', 'P1', 900, 1800, Date.new(2004, 1), Date.new(2004, 6)]
	]

g = x.collect {|item| item[2]}.uniq.product(x.collect {|item| item[3]}.uniq)


