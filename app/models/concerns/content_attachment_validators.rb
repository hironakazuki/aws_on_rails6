module ContentAttachmentValidators
  extend ActiveSupport::Concern
  included do
    validate :validate_content_length
    validate :validate_content_attachment_byte_size
    validate :validate_content_attachment_file_length
  end
  MAX_CONTENT_LENGTH = 300
  ONE_KILOBYTE = 1024
  MEGA_BYTES = 3
  MAX_CONTENT_ATTACHMENT_BYTE_SIZE = MEGA_BYTES * 1_000 * ONE_KILOBYTE
  MAX_CONTENT_ATTACHMENTS_COUNT = 4
  private

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

  def validate_content_attachment_byte_size
    content.body.attachables.grep(ActiveStorage::Blob).each do |attachable|
      if attachable.byte_size >= MAX_CONTENT_ATTACHMENT_BYTE_SIZE
        errors.add(
          :content,
          :content_attachment_byte_size_is_too_big,
          max_content_attachment_mega_byte_size: MEGA_BYTES,
          max_content_attachment_byte_size: MAX_CONTENT_ATTACHMENT_BYTE_SIZE,
          byte_size: attachable.byte_size
          )
      end
    end
  end

  def validate_content_attachment_file_length
    length = content.body.attachables.grep(ActiveStorage::Blob).count

    if length > MAX_CONTENT_ATTACHMENTS_COUNT
      errors.add(
        :content,
        :content_attachments_count_is_too_big,
        max_content_attachments_count: MAX_CONTENT_ATTACHMENTS_COUNT,
        length: length
        )
    end
  end
end