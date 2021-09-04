@user = User.create!(username: "admin",
                    email: "firesoul0608@gmail.com",
                    password: "123456",
                    password_confirmation: "123456",
                    status: true,
                    role: 0,
                    created_at: Faker::Time.between(from: DateTime.now - 762, to: DateTime.now),
                    updated_at: Faker::Time.between(from: DateTime.now - 762, to: DateTime.now))
@user.create_user_profile(fullname: @user.username)
90.times do |n|
  name = Faker::Name.name
  email = "elearning-#{n+1}@gmail.com"
  @user = User.create!(username: name,
                        email: email,
                        password: "123456",
                        password_confirmation: "123456",
                        status: true,
                        role: 2,
                        created_at: Faker::Time.between(from: DateTime.now - 762, to: DateTime.now),
                        updated_at: Faker::Time.between(from: DateTime.now - 762, to: DateTime.now))
  @user.create_user_profile(fullname: @user.username)
end
36.times do 
  name = "Course of " + Faker::University.name
  decription = Faker::Quote.matz
  users = (0...(User.all.count)).to_a
  ran = users.sample
  @cate = Category.new(name: name, decription: decription, user_id: ran, status: 1)
  while @cate.save == false
    name = "Course of " + Faker::University.name
    decription = Faker::Quote.matz
    @cate = Category.new(name: name, decription: decription, user_id: ran, status: 1)
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
