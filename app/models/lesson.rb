class Lesson < ApplicationRecord
  belongs_to :category
  
  has_many :content_lessons, dependent: :destroy
  has_many :questions, dependent: :destroy
end
