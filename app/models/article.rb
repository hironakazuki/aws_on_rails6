class Article < ApplicationRecord
  has_rich_text :content

  validates :title, presence:true, uniqueness: { case_sensitive: true }, length: { maximum: 64 }
  validates :content, presence: true
  
  include ContentAttachmentValidators
end
