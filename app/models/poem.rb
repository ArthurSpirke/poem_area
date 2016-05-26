# == Schema Information
#
# Table name: poems
#
#  id           :integer          not null, primary key
#  author_id    :integer
#  title        :string
#  metaphor     :text
#  content      :text
#  published    :boolean
#  publish_date :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Poem < ActiveRecord::Base
  include Tags

  belongs_to :author
  has_many   :tag_connections, class_name: 'TagPoem', dependent: :destroy
  has_many   :tags, through: :tag_connections, source: :tag

  validates :author_id, :title, :metaphor, :content, presence: true
  validates :metaphor, length: { maximum: 1000 }
  validates :content,  length: { maximum: 5000 }

  scope :by_tag_title, -> (tag_title) { joins(tag_connections: :tag).where(tags: {title: tag_title}) }

  after_save :update_tags, :update_publish_date

  TAG_TYPES = ["title", "metaphor", "content"]

  def publish!
    self.published = true
    self.save
  end

  def unpublish!
    self.published = false
    self.save
  end

  def published?
    published
  end

  def tag_service
    @tag_service ||= TagService.new(self, TAG_TYPES)
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
