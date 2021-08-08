class CreateContentLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :content_lessons do |t|
      t.string :word
      t.string :pronounce
      t.string :mean
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
