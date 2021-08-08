class Lesson < ApplicationRecord
  belongs_to :category
  has_many :content_lessons, dependent: :destroy
end
