
INITIAL_TAGS = [
  "story",
  "fantastic",
  "poem",
  "age",
  "animal",
  "hero",
  "human",
  "king",
  "queen",
  "kingdom",
  "throne",
  "sword",
  "power",
  "love",
  "honor",
  "glory",
  "fight",
  "death",
  "life",
  "family"
]

INITIAL_TAGS.each do |tag_word|
  Tag.find_or_create_by(title: tag_word)
end

p "Tags in system - #{Tag.count}"
