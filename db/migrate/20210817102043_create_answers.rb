class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :content_lesson, null: false, foreign_key: true
      t.boolean :right_ans
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
