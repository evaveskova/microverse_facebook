# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: "author_id"
  validates :content, presence: true, length: { minimum: 2 }
  # validates :author, presence: true 
  default_scope -> { order(created_at: :desc) }
end
