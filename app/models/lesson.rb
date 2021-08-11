class Lesson < ApplicationRecord
  belongs_to :category
  self.per_page = Settings.WillPaginate.less_per_page
  has_many :content_lessons, dependent: :destroy
  has_many :questions, dependent: :destroy
end
