class ContentLesson < ApplicationRecord
  validates :word, presence: :true, uniqueness: true
  validates :mean, presence: :true, uniqueness: true
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  self.per_page = Settings.WillPaginate.  content_per_page
  has_one_attached :image
  validates :image, content_type: { in: %w[image/jpg image/jpeg image/png],
    message: :image_errors1},
        size: { less_than: 5.megabytes,
                  message: :image_errors2 }
  has_one_attached :audio_word
  validates :audio_word, content_type: { in: %w[audio/mp3 audio/mpeg],
    message: :audio_error }
end
