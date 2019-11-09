require 'csv'

fn = File.join('seeds', 'exercises.csv')

# columns Assignment, Points, Link
exercises = CSV.parse(File.read(fn), headers: true)

exercises.each do |exercise|
  puts "#{exercise["Assignment"]} - #{exercise["Link"]} - #{exercise["Points"]}"
end
