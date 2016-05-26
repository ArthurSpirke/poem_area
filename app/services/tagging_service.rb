class TaggingService

  attr_reader :object, :content_types

  def initialize(object, content_types)
    @object = object
    @content_types = content_types
  end

  def tag_content
    clear_tags
    counted_content_container = {}
    content_types.each do |content_type|
      counted_content_container[content_type] = count_words(object.send(content_type))
    end
    process_words(counted_content_container)
  end

  def count_words(content)
    container = {}
    words = remove_punctuation(content).split(' ')
    words.each do |word|
      word = word.downcase
      if container[word]
        container[word] += 1
      else
        container[word] = 1
      end
    end
    container
  end

  def remove_punctuation(content)
    content.downcase.gsub(/[^a-z0-9\s]/i, '')
  end

  def process_words(counted_content_container)
    collected_tags_with_weight = {}
    counted_content_container.each do |content_type, counted_words|
      counted_words.each do |word, count|
        if tag_words.include?(word)
          collected_tags_with_weight[word] = collected_tags_with_weight[word].to_i + count
        end
      end
    end
    save_tags(collected_tags_with_weight)
  end

  def save_tags(collected_tags_with_weight)
    collected_tags_with_weight.each do |word, weight|
      tag = Tag.find_by(title: word)
      object.tag_connections.create(tag_id: tag.id, weight: weight)
    end
  end

  def clear_tags
    object.tag_connections.destroy_all
  end

  def tag_words
    @tag_words ||= Tag.pluck(:title).map(&:downcase)
  end

end
