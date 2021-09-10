require "rails_helper"

RSpec.describe Category, type: :model do
  current_user = User.first_or_create!(username: "leduyvuong", email: "leduyvuong99@gmail.com",
                                      password: "123456", password_confirmation: "123456", role: 0)
  fifty_charater = "LxwbffQk2o2tZGVT1mBWqCurgF2UiCVLiJ5uwpRJGWIQAW2bnYa"
  thirty_charater = "1aDm9VfJOo5LHjEIr0gNFGkkZ49up"
  thirty_one_charater = "1aDm9VfJOo5LHjEIr0gNFGkkZ49upna"
  it "has a name" do
    category = Category.new(name: "", 
                decription: thirty_one_charater)
    expect(category).to_not  be_valid
    category.name = "Has a name"
    expect(category).to  be_valid
  end

  it "has a description" do
    category = Category.new(name: "a valid name", 
      decription: "")
    expect(category).to_not  be_valid
    category.decription = thirty_one_charater
    expect(category).to  be_valid
  end

  it "has a name no longer than 50 charaters" do
    category = Category.new(name: fifty_charater, 
                            decription: thirty_one_charater)
    expect(category).to_not  be_valid
    category.name = "a valid name"
    expect(category).to  be_valid
  end

  it "has a description at least 30 charaters" do
    category = Category.new(name: "a valid name", 
                            decription: thirty_charater)
    expect(category).to_not  be_valid
    category.decription = thirty_one_charater
    expect(category).to  be_valid
  end
end