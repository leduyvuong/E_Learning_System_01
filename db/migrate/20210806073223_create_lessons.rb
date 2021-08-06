class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.string :name_lesson
      t.integer :time
      t.boolean :status
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
