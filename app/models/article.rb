class Article < ApplicationRecord
  has_rich_text :content

  validates :title, presence:true, length: { maximum: 32 }
  validates :content, presence: true
  
  include ContentAttachmentValidators
end
