# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_many :tag_authors
  has_many :tag_poems
  has_many :tag_short_stories

  has_many :authors, through: :tag_authors, source: :author
  has_many :poems, through: :tag_poems, source: :poem
  has_many :short_story, through: :tag_short_stories, source: :short_story

  def self.grouped_authors_connections
    group_by_title("tag_authors")
  end

  def self.grouped_poems_connections
    group_by_title("tag_poems")
  end

  def self.grouped_short_stories_connections
    group_by_title("tag_short_stories")
  end

  def self.group_by_title(join_table)
    query = <<-SQL
      SELECT t.title, count(*) counter
      FROM tags t
      INNER JOIN #{join_table} jt
      ON t.id = jt.tag_id
      GROUP BY t.title
    SQL
    results = ActiveRecord::Base.connection.execute(query)
    tags_container = results.present? ? Hash[results.map { |row| [row["title"], row["counter"]] } ] : {}
    tags_container.sort_by { |key, value| -value }
  end

end
