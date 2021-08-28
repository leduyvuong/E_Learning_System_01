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
    active_hash = Hash.new
    id_last = ContentLesson.last.id
    
    (2..spreadsheet.last_row).each do |i|
      row = [header, spreadsheet.row(i)].transpose.to_h
      if contents.blank?
        content = new(id: id_last + i - 1, word: row["word"], pronounce: row["pronounce"],mean: row["mean"],lesson_id: row["lesson_id"])
        
        if content.valid?
          contents << content 
          active_hash["#{content.id}"] = save_url row["audio"], row["image"]
        end
      else
        contents.each do |c|
          if c.word == row["word"]
            temp += 1
            break
          end             
        end
        if temp == 0
          content = new(id: id_last + i - 1, word: row["word"], pronounce: row["pronounce"], mean: row["mean"],lesson_id: row["lesson_id"]) 
          if content.valid?
            contents << content 
            active_hash["#{content.id}"] = save_url row["audio"], row["image"]
          end
        else
          temp = 0
        end
      end
    end
    import! contents, validate: true, on_duplicate_key_ignore: true
    # Dùng cái gem activerecord-import nên lúc lưu nó chỉ có lệnh insert của contentlesson. save_image_audio 
    save_image_audio active_hash
  end 
end

def save_url audio, image, url
  url = "C:/Users/OS/Desktop/RIKAI TECHNOLOGY/Project1/audio/"
  image_audio = Hash.new
  pathname_image = Pathname.new(url + image) 
  pathname_audio = Pathname.new(url + audio)
  image_audio["image"] = pathname_image
  image_audio["audio"] = pathname_audio
  image_audio
end

def save_image_audio active_hash
  id_array = active_hash.keys.join(", ") 
  contents = ContentLesson.where("id in (#{ id_array})")
  contents.each do |content|
    pathname_image = active_hash["#{content.id}"]["image"]
    pathname_audio = active_hash["#{content.id}"]["audio"]
    content.image.attach(io: File.open(pathname_image),
                              filename: pathname_image.basename.to_s, 
                              content_type: Rack::Mime.mime_type(pathname_image.extname))
    content.audio_word.attach(io: File.open(pathname_audio),
                              filename: pathname_audio.basename.to_s, 
                              content_type: Rack::Mime.mime_type(pathname_audio.extname))
  end
end