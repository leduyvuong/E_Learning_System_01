class ContentLesson < ApplicationRecord
  default_scope -> { order(word: :asc) }
  self.per_page = Settings.WillPaginate.word_per_page
  scope :search_name, -> (word){ where("word like ?", "%#{word}%")}
  validates :word, presence: :true, uniqueness: true
  validates :mean, presence: :true, uniqueness: true
  belongs_to :lesson
  def self.search(word)
    if word
      search_name word
    else
      all
    end
  end
end
