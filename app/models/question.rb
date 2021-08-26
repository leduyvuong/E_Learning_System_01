class Question < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  self.per_page = Settings.WillPaginate.question_per_page
  validates :content, presence: :true
end
