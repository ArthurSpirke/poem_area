class CreatePoem < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.integer  :author_id
      t.string   :title
      t.text     :metaphor
      t.text     :content
      t.boolean  :published
      t.datetime :publish_date

      t.timestamps
    end

    add_index :poems, :author_id
  end
end
