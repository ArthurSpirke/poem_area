class CreateTagShortStory < ActiveRecord::Migration
  def change
    create_table :tag_short_stories do |t|
      t.integer :tag_id
      t.integer :short_story_id
      t.integer :weight
    end

    add_index :tag_short_stories, :tag_id
    add_index :tag_short_stories, :short_story_id
  end
end
