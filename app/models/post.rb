# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  validates :content, presence: true, length: { minimum: 2 }
  # validates :author, presence: true
  default_scope -> { order(created_at: :desc) }

  def self.visible_to_user(user)
    find_by_sql(["SELECT * FROM posts
      WHERE author_id = ?
      OR author_id IN (
        SELECT friend_id FROM friendships
          WHERE user_id = ?)
      ORDER BY posts.updated_at DESC", user.id, user.id])
  end
end
