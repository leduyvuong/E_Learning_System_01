class ResultLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  has_many :activities, as: :owner
  scope :found_result_user, ->(user_id, lesson_id){ where("user_id = ? and lesson_id= ?", user_id, lesson_id)}
  scope :found_cate_user, ->(user_id, lesson_id){ where("user_id = ? and lesson_id in (?)", user_id, lesson_id)}
  scope :result_user, ->(user_id) { where("user_id = ?", user_id)}
  def self.found_user user_id, lesson_id
    if user_id && lesson_id
      found_result_user user_id, lesson_id
    end
  end
  def self.found_cate user_id, lesson_id
    
    if user_id && lesson_id

      found_cate_user user_id, lesson_id
    end
  end
end

