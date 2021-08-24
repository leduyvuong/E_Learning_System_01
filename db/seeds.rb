@user = User.create!(username: "admin",
                    email: "firesoul0608@gmail.com",
                    password: "123456",
                    password_confirmation: "123456",
                    status: true,
                    admin: true)
@user.create_user_profile(fullname: @user.username)
30.times do |n|
  name = Faker::Name.name
  email = "elearning-#{n+1}@gmail.com"
  @user = User.create!(username: name,
                        email: email,
                        password: "123456",
                        password_confirmation: "123456",
                        status: true,
                        admin: false)
  @user.create_user_profile(fullname: @user.username)
end
36.times do 
  name = "Course of " + Faker::University.name
  decription = Faker::Quote.matz
  @cate = Category.new(name: name, decription: decription, status: true)
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
#create question
@lessons = Lesson.all
@lessons.each do |l|
  @content_lessons = l.content_lessons
  @content_lessons.each do |w|
    @content_question = "What does '#{w.word}' mean :"
    @ques = l.questions.create!(content: @content_question)
    #create answer
    @ques.answers.create!(content: w.mean, right_ans: true)
    @count = @content_lessons.count
    @dem = @content_lessons.index(w)
    a  = (0...@count).to_a
    a.delete(@dem)
    @ran1 = a.sample
    a.delete(@ran1)
    @ran2 = a.sample
    a.delete(@ran2)
    @ran3 = a.sample
    a.delete(@ran3)
    @ques.answers.create!(content: @content_lessons[@ran1].mean, right_ans: false)
    @ques.answers.create!(content: @content_lessons[@ran2].mean, right_ans: false)
    @ques.answers.create!(content: @content_lessons[@ran3].mean, right_ans: false)
  end
end