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
  def self.import_file file
    spreadsheet = Roo::Spreadsheet.open file
    header = spreadsheet.row(1)
    contents = []
    temp = 0
    (2..spreadsheet.last_row).each do |i|
      row = [header, spreadsheet.row(i)].transpose.to_h
      if contents.blank?
        content = new(word: row["word"], pronounce: row["pronounce"],mean: row["mean"],lesson_id: row["lesson_id"])            
        contents << content if content.valid?
      else
        contents.each do |c|
          if c.word == row["word"]
            temp += 1
            break
          end             
        end
        if temp == 0
          content = new(word: row["word"], pronounce: row["pronounce"], mean: row["mean"],lesson_id: row["lesson_id"]) 
          contents << content if content.valid?
        else
          temp = 0
        end
      end
    end
    import! contents, validate: true, on_duplicate_key_ignore: true
  end 
end
