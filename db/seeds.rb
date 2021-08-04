36.times do |n|
  name = "Course of " + Faker::University.name
  decription = Faker::Quote.matz
  Category.create!(name: name, decription: decription)
end 