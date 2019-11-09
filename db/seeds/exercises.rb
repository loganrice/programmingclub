require 'csv'

fn = File.join(Rails.root, 'db', 'seeds', 'exercises.csv')

# columns exercsises.csv Assignment, Points, Link
exercises = CSV.parse(File.read(fn), headers: true)

exercises.each do |exercise|
  Exercise.create(
    name: exercise["Assignment"],
    link: exercise["Link"],
    points: exercise["Points"])
end
