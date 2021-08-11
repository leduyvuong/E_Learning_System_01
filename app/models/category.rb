class Category < ApplicationRecord
  scope :sp, -> { where(status: true)}
  # Ex:- scope :active, -> {where(:active => true)}
  has_many :users, through: :wordlists
  has_many :wordlists, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_one_attached :image
  self.per_page = Settings.WillPaginate.cate_per_page
  validates :name, presence: true, length: {maximum: 50}
  validates :decription, presence: true, length: {minimum: 30}
end
