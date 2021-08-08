36.times do 
  name = "Course of " + Faker::University.name
  decription = Faker::Quote.matz
  @cate = Category.new(name: name, decription: decription)
  while @cate.save == false
    name = "Course of " + Faker::University.name
    decription = Faker::Quote.matz
    @cate = Category.new(name: name, decription: decription)
  end
end 
cate = Category.order(:created_at).take(6)
3.times do |n|  
  cate.each do |c|
    name = Faker::Game.title
    time = Faker::Number.between(from: 1, to: 200)
    status = 1
    less = c.lessons.create!(name_lesson: name, time: time, status: status)
    20.times do
      Faker::Config.locale = 'en'
      word = Faker::Lorem.word
      Faker::Config.locale = 'vi'
      mean = Faker::Lorem.word
      @conten = less.content_lessons.new(word: word, mean: mean)
      while @conten.save == false
        Faker::Config.locale = 'en'
        word = Faker::Lorem.word
        Faker::Config.locale = 'vi'
        mean = Faker::Lorem.word
        @conten = less.content_lessons.new(word: word, mean: mean)
      end
    end
  end
end