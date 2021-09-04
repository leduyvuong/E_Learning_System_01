class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end
