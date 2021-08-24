class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :users, through: :wordlists
  scope :search_name, -> (name){ where("name like ?", "%#{name}%")}
  scope :active, -> { where(status: true)}
  has_one_attached :image
  self.per_page = Settings.WillPaginate.cate_per_page
  validates :name, presence: true, length: {maximum: 50}
  validates :decription, presence: true, length: {minimum: 30}
  def self.search(name)
    if name
      categories = search_name name
      return categories unless categories.blank?
      all
    else
      all
    end
  end
end
