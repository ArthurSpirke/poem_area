class CreateTagAuthor < ActiveRecord::Migration
  def change
    create_table :tag_authors do |t|
      t.integer :tag_id
      t.integer :author_id
      t.integer :weight
    end

    add_index :tag_authors, :tag_id
    add_index :tag_authors, :author_id
  end
end
