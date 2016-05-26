module Tags
  extend ActiveSupport::Concern

  def all_tags
    tag_service.all
  end

  def grouped_tags_by_types
    tag_service.all_grouped_by_types
  end

  def tags_by_type(type)
    tag_service.by_type(type)
  end

  def tag_service
    @tag_service ||= TagService.new(self, TAG_TYPES)
  end

end
