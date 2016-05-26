# == Schema Information
#
# Table name: tag_authors
#
#  id        :integer          not null, primary key
#  tag_id    :integer
#  author_id :integer
#  weight    :integer
#

class TagAuthor < ActiveRecord::Base
  belongs_to :tag
  belongs_to :author

  scope :ordered_by_weigth, -> { order(weight: :desc) }

end
