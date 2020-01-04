require 'csv'

# ---------- Create Units ------------------
unitsNames = [
  "Basics and Printing",
  "Variables",
  "Keyboard Input",
  "GUI",
  "If Statements",
  "Random Numbers",
  "While Loops",
  "Functions",
  "For Loops",
  "Nested Loops",
  "File Input and Output",
  "Arrays",
  "Sorting",
  "Records",
  "ArrayLists"
]

unitsNames.each_with_index do |unit, i|
  record = Unit.find_or_create_by(name: unit)
  record.order = i
  record.save
end


# ---------- Create Exercises ------------------

fn = File.join(Rails.root, 'db', 'seeds', 'exercises.csv')

# columns exercsises.csv Assignment, Points, Link, Unit
exercises = CSV.parse(File.read(fn), headers: true)

exercises.each_with_index do |exercise, i|
  record = Exercise.find_or_create_by(name: exercise["Assignment"])
  record.link = exercise["Link"]
  record.points = exercise["Points"]
  record.order = i
  record.unit_id = Unit.find_by(name: exercise["Unit"]).id
  record.save
end

