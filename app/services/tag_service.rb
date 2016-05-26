class TagService

  attr_reader :object, :tag_types

  def initialize(object, tag_types)
    @object = object
    @tag_types = tag_types
  end

  def all
    tags_grouped_by_types.values.flatten
  end

  def all_grouped_by_types
    tags_grouped_by_types
  end

  def by_type(type)
    tags_grouped_by_types[type]
  end

  private

  def tags_grouped_by_types
    @tags_grouped_by_types ||= begin
      data = object.tag_connections.includes(:tag).group_by(&:specific_content_type).each { |specific_content_type, tags_conn| [specific_content_type, tags_conn.map(&:tag)] }
      Hash[data]
    end
  end

end
