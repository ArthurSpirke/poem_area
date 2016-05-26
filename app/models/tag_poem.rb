# == Schema Information
#
# Table name: tag_poems
#
#  id      :integer          not null, primary key
#  tag_id  :integer
#  poem_id :integer
#  weight  :integer
#

class TagPoem < ActiveRecord::Base
  belongs_to :tag
  belongs_to :poem

  scope :ordered_by_weigth, -> { order(weight: :desc) }

end
