class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :description
      t.integer :likes
      t.references :agenda

      t.timestamps
    end
    add_index :ideas, :agenda_id
  end
end
