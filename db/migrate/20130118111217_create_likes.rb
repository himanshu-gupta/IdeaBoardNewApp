class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.references :agenda
      t.references :idea

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :agenda_id
    add_index :likes, :idea_id
  end
end
