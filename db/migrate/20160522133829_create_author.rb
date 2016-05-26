class CreateAuthor < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.text   :biography

      t.timestamps
    end
  end
end
