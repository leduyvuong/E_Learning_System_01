class User < ApplicationRecord
  has_one :user_profile
  default_scope -> { order(status: :desc) }
  self.per_page = Settings.WillPaginate.user_per_page
  has_many :summaries, dependent: :destroy
  has_many :wordlists, dependent: :destroy
  has_many :categories, through: :wordlists
  scope :search_name, -> (user){ where("username like ?", "%#{user}%")}
  # Ex:- scope :active, -> {where(:active => true)}
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  validates :username, presence: true, length: {maximum: 50}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, 
                          format: { with: VALID_EMAIL_REGEX }, 
                          uniqueness: true
  def follow(other_user)
    following << other_user
  end
  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end
  # Returns true if the current user is following the other user.
  def following?(id_user)
    other_user = User.find(id_user)
    following.include?(other_user)
  end
  def self.search(user)
    if user
      search_name user
    else
      all
    end
  end 
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true 
  def User.digest(string)
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      cost = BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end
end
