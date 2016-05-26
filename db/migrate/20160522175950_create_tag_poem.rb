class CreateTagPoem < ActiveRecord::Migration
  def change
    create_table :tag_poems do |t|
      t.integer :tag_id
      t.integer :poem_id
      t.integer :weight
    end

    add_index :tag_poems, :tag_id
    add_index :tag_poems, :poem_id
  end
end
