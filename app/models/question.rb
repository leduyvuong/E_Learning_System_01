class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  self.per_page = Settings.WillPaginate.test_per_page
  belongs_to :lesson
end
