# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  name       :string
#  biography  :text
#  created_at :datetime
#  updated_at :datetime
#

class Author < ActiveRecord::Base
  include Tags

  has_many :short_stories
  has_many :poems
  has_many :tag_connections, class_name: "TagAuthor", dependent: :destroy
  has_many :tags, through: :tag_connections, source: :tag

  validates :name, :biography, presence: true
  validates :biography, length: { maximum: 2500 }

  scope :by_tag_title, -> (tag_title) { joins(tag_connections: :tag).where(tags: {title: tag_title}) }

  after_save :update_tags

  TAG_TYPES = ["biography"]

  def tag_service
    @tag_service ||= TagService.new(self, TAG_TYPES)
  end

  def update_tags
    TaggingService.new(self, TAG_TYPES).tag_content
  end

end
