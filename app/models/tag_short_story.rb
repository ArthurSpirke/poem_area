# == Schema Information
#
# Table name: tag_short_stories
#
#  id             :integer          not null, primary key
#  tag_id         :integer
#  short_story_id :integer
#  weight         :integer
#

class TagShortStory < ActiveRecord::Base
  belongs_to :tag
  belongs_to :short_story

  scope :ordered_by_weigth, -> { order(weight: :desc) }
  
end
