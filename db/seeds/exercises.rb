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
  "For Loops",
  "Functions",
  "Nested Loops",
  "File Input and Output",
  "Arrays",
  "Sorting",
  "Records",
  "ArrayLists"
]

unitsNames.each do |unit|
  Unit.find_or_create_by(name: unit)
end


# ---------- Create Exercises ------------------

fn = File.join(Rails.root, 'db', 'seeds', 'exercises.csv')

# columns exercsises.csv Assignment, Points, Link, Unit
exercises = CSV.parse(File.read(fn), headers: true)

exercises.each do |exercise|
  Exercise.find_or_create_by(
    name: exercise["Assignment"],
    link: exercise["Link"],
    points: exercise["Points"],
    unit_id: Unit.find_or_create_by(name: exercise["Unit"]).id  
  )
end

