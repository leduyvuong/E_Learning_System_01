class Wordlist < ApplicationRecord
  belongs_to :user
  has_many :activities, as: :owner
  scope :found_category, -> wordlist { where("category_id = ? and user_id = ?", wordlist[:category_id], wordlist[:user_id])}
  scope :category_filter, -> (name){ joins(:category).where("categories.name = ?",name)}
  belongs_to :category
  def self.found_dup category_id, user_id
    if category_id && user_id
      wordlist = {}
      wordlist[:category_id] = category_id
      wordlist[:user_id] = user_id
      found_category wordlist
    end
  end
  def self.filter name
    if name
      category_filter("#{name}").group(:name).group_by_week(:created_at, format: "%d").count
    else
      category_filter("Course of Tú Institute").group(:name).group_by_week(:created_at).count
    end
  end
end
