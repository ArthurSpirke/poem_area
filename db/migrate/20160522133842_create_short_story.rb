class CreateShortStory < ActiveRecord::Migration
  def change
    create_table :short_stories do |t|
      t.integer  :author_id
      t.string   :title
      t.text     :description
      t.text     :content
      t.boolean  :published
      t.datetime :publish_date

      t.timestamps
    end

    add_index :short_stories, :author_id
  end
end
