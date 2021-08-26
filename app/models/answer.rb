class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :content_lesson
  self.per_page = Settings.WillPaginate.answer_per_page
  scope :right_answer, -> { where(right_ans: true)}
end
