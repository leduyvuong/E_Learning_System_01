@user = User.create!(username: "admin",
                    email: "firesoul0608@gmail.com",
                    password: "123456",
                    password_confirmation: "123456",
                    status: true,
                    role: 0)
@user.create_user_profile(fullname: @user.username)
30.times do |n|
  name = Faker::Name.name
  email = "elearning-#{n+1}@gmail.com"
  @user = User.create!(username: name,
                        email: email,
                        password: "123456",
                        password_confirmation: "123456",
                        status: true,
                        role: 2)
  @user.create_user_profile(fullname: @user.username)
end
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
cate = Category.order(:created_at).take(3)
3.times do  
  cate.each do |c|
    name = Faker::Game.title
    time = Faker::Number.between(from: 1, to: 200)
    status = 1
    less = c.lessons.create!(name_lesson: name, time: time, status: status)
    10.times do
      Faker::Config.locale = "en"
      word = Faker::Lorem.word
      Faker::Config.locale = "vi"
      mean = Faker::Lorem.word
      @conten = less.content_lessons.new(word: word, mean: mean)
      while @conten.save == false
        Faker::Config.locale = "en"
        word = Faker::Lorem.word
        Faker::Config.locale = "vi"
        mean = Faker::Lorem.word
        @conten = less.content_lessons.new(word: word, mean: mean)
      end
    end
  end
end
