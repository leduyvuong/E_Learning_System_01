class Category < ApplicationRecord
  has_many :wordlists, dependent: :destroy
  has_many :lessons, dependent: :destroy
  self.per_page = Settings.WillPaginate.cate_per_page
  validates :name, presence: true, length: {maximum: 50}
  validates :decription, presence: true, length: {minimum: 30}
end
