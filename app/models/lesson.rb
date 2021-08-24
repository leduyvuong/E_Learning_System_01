class Lesson < ApplicationRecord
  belongs_to :category
  self.per_page = Settings.WillPaginate.lesson_per_page
  has_many :content_lessons, dependent: :destroy
  has_many :questions, dependent: :destroy
  default_scope -> { order(category_id: :asc) }
  validates :name_lesson, presence: :true
  validates :time, numericality: { only_integer: true }
end
