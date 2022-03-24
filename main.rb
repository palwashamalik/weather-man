require_relative './Extreme_weather'
require_relative './average_weather'

def user_input
  raise 'Wrong User Input' unless ARGV[0].to_s == '-e' || ARGV[0].to_s == '-a'

  ExtremeWeather.new(ARGV[1].to_s) if ARGV[0].to_s == '-e'
  AverageWeather.new(ARGV[1].split('/')[0].to_s, ARGV[1].split('/')[1].to_s) if ARGV[0].to_s == '-a'
end

begin
  object = user_input
  IO.sysopen(ARGV[2].to_s)
  main_directory = Dir.glob("#{ARGV[2].to_s}/*")
  main_directory.each do |f|
    IO.sysopen(f)
    sub_directory = Dir.glob("#{f}/*")
    sub_directory.each do |filename|
      object.read_file_data(filename)
    end
  end
  object.print_values
rescue Errno::ENOENT
  puts 'No such directory'
end
