class ContentLesson < ApplicationRecord
  validates :word, presence: :true, uniqueness: true
  self.per_page = Settings.WillPaginate.content_per_page
  validates :mean, presence: :true, uniqueness: true
  belongs_to :lesson
end
