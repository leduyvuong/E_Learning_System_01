class Wordlist < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :category
  belongs_to :user
end
