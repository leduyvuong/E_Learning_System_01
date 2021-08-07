36.times do 
  name = "Course of " + Faker::University.name
  decription = Faker::Quote.matz
  Category.create!(name: name, decription: decription)
end 
cate = Category.order(:created_at).take(10)
6.times do |n|  
  cate.each do |c|
    name = Faker::Game.title
    time = Faker::Number.between(from: 1, to: 200)
    status = 1
    c.lessons.create!(name_lesson: name, time: time, status: status)
  end
end