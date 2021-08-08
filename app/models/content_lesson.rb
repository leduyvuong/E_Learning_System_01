class ContentLesson < ApplicationRecord
  default_scope -> { order(word: :desc) }
  validates :word, presence: :true, uniqueness: true
  validates :mean, presence: :true, uniqueness: true
  belongs_to :lesson
end
