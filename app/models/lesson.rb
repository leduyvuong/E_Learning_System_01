class Lesson < ApplicationRecord
  before_create :default_status
  belongs_to :category
  has_many :result_lessons, dependent: :destroy
  has_many :users, through: :result_lessons
  scope :lesson_active, -> { where(status: true)}
  self.per_page = Settings.WillPaginate.lesson_per_page
  has_many :content_lessons, dependent: :destroy
  has_many :questions, dependent: :destroy
  scope :filter_cate, -> { order(category_id: :asc)}
  validates :name_lesson, presence: :true
  validates :time, numericality: { only_integer: true }
  def default_status
    self.status ||= true
  end
end
