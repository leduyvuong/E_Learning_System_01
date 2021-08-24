class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: :true
  self.per_page = Settings.WillPaginate.answer_per_page
  scope :right_answer, -> { where(right_ans: true)}
end
