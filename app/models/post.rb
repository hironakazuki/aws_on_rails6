class Post < ApplicationRecord
  has_rich_text :content

  validates :title, presence:true, uniqueness: { case_sensitive: true }, length: { maximum: 32 }
  validates :content, presence: true
  
  include ContentAttachmentValidators
end
