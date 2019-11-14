class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy
  validates :content, presence: true
end
