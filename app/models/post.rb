class Post < ApplicationRecord
	
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  validates :content, presence: true, length: { minimum: 2 }
  # validates :author, presence: true 
end
