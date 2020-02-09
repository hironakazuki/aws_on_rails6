class Post < ApplicationRecord
  has_rich_text :content

  validates :title, presence:true, length: { maximum: 32 }
  validates :content, presence: true
  
  validate :validate_content_length

  MAX_CONTENT_LENGTH = 50

  def validate_content_length
    length = content.to_plain_text.length

    if length > MAX_CONTENT_LENGTH
      errors.add(
        :content,
        :too_long_post_content,
        max_content_length: MAX_CONTENT_LENGTH,
        length: length
        )
    end
  end
end
