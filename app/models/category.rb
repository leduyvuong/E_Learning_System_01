class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :users, through: :wordlists
  self.per_page = Settings.WillPaginate.cate_per_page
  validates :name, presence: true, length: {maximum: 50}
  validates :decription, presence: true, length: {minimum: 30}
end
