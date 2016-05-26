# == Schema Information
#
# Table name: short_stories
#
#  id           :integer          not null, primary key
#  author_id    :integer
#  title        :string
#  description  :text
#  content      :text
#  published    :boolean
#  publish_date :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortStory < ActiveRecord::Base
  include Tags

  belongs_to :author
  has_many   :tag_connections, class_name: "TagShortStory", dependent: :destroy
  has_many   :tags, through: :tag_connections, source: :tag

  validates :author_id, :title, :description, :content, presence: true
  validates :description, length: { maximum: 1000 }
  validates :content,     length: { maximum: 5000 }

  scope :by_tag_title, -> (tag_title) { joins(tag_connections: :tag).where(tags: {title: tag_title}) }

  after_save :update_tags, :update_publish_date

  TAG_TYPES = ['title', 'description', 'content']

  def publish!
    self.publish_date = DateTime.now
    self.save
  end

  def unpublish!
    self.publish_date = nil
    self.save
  end

  def update_tags
    TaggingService.new(self, TAG_TYPES).tag_content
  end

  def update_publish_date
    if published_changed? && published
      update_column(:publish_date, DateTime.now)
    end
  end

end
