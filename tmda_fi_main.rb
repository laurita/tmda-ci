$LOAD_PATH.unshift File.dirname(__FILE__)

require 'optparse'
require 'sqlite3'
require 'tmda_fi'
require 'pp'

def main()
  options = OptparseCI.parse(ARGV)
  db = SQLite3::Database.open(options[:db])
  g = db.execute(options[:group_sql])
  r = db.execute(options[:source_sql])
  f = [options[:func], options[:func_arg]]
  theta = options[:theta]
  c = options[:c]
  start_time = Time.now
  result = tmda_fi(g,r,f,theta,c)
  duration = Time.now - start_time
  puts result.inspect
  puts "Calculation took #{duration} seconds."
end

class OptparseCI
  def self.parse(args)
    options = {}
    options[:theta] = []
    
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: tmda_fi_main.rb [options]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("--database DB",
              "Path to SQLite DB") do |db|
        options[:db] = db
      end
      
      opts.on("--group_sql SQL",
              "Ex. 'SELECT * FROM group_table'") do |gsql|
        options[:group_sql] = gsql
      end
      
      opts.on("--source_sql SQL",
              "Ex. 'SELECT * FROM table'") do |sql|
        options[:source_sql] = sql
      end
      
      opts.on("--function NAME",
              "") do |func|
        options[:func] = func
      end
      
      opts.on("--function_argument COLUMN_NUM", Integer,
              "argument column number") do |n|
        options[:func_arg] = n
      end
      
      opts.on("--c C",
                "attribute characteristic") do |c|
        options[:c] = c
      end
      
      opts.on("--theta X1-X2,Y1-Y2", Array, "Examples") do |list|
        list.each do |el|
          a, b = el.split("-")
          options[:theta] << [a.to_i, b.to_i]
        end
      end
      
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

    end

    opts.parse!(args)
    raise OptionParser::MissingArgument if options[:db].nil?
    raise OptionParser::MissingArgument if options[:theta] == []
    raise OptionParser::MissingArgument if options[:db].nil?
    raise OptionParser::MissingArgument if options[:db].nil?
    raise OptionParser::MissingArgument if options[:db].nil?
    
    options
  end

end

if __FILE__ == $0
  main()
end