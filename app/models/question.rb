class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  validates :content, presence: :true
  belongs_to :lesson
end
