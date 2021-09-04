class Activity < ApplicationRecord
  belongs_to :owner, polymorphic: true
  self.per_page = Settings.WillPaginate.activity_per_page
  scope :activity_user, lambda { |user_id|
    if user_id
      where("user_id in (?)", user_id).order(created_at: :desc)
    end
  }
end
