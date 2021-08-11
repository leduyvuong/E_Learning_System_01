class Lesson < ApplicationRecord
  belongs_to :category
  default_scope -> { order(category_id: :asc) }
  validates :name_lesson, presence: :true
  validates :time, numericality: { only_integer: true }
  self.per_page = Settings.WillPaginate.less_per_page
  has_many :content_lessons, dependent: :destroy
  has_many :questions, dependent: :destroy
  scope :search_name, -> (name){ where("name_lesson like ?", "%#{name}%")}
  def self.search(name)
    if name
      search_name name
    else
      all
    end
  end
end
