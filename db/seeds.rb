36.times do 
  name = "Course of " + Faker::University.name
  decription = Faker::Quote.matz
  Category.create!(name: name, decription: decription)
end 