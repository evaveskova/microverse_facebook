# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :destroy

  validates :first_name, presence: true, length: { within: 4..20 }
  validates :last_name, presence: true, length: { within: 4..20 }
  validates :email, presence: true, format: Devise.email_regexp
  validates :gender, presence: true, inclusion: { in: %w[male female custom] }
  validates :birthday, presence: true

  before_save :downcase_email
  before_save :capitalize_names
  before_create :gravatar_image_url

  def self.find_confirmed_friends(user)
    find_by_sql(["SELECT * FROM users
      WHERE id IN (
        SELECT friend_id FROM friendships
          WHERE user_id = ?
          AND status = true)
      ORDER BY users.updated_at DESC", user.id])
  end
  
  def self.find_pending_friends(user)
    find_by_sql(["SELECT * FROM users
      WHERE id IN (
        SELECT friend_id FROM friendships
          WHERE user_id = ?
          AND status = false)
      ORDER BY users.updated_at DESC", user.id])
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def gravatar_image_url
    self.image = "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end

  def capitalize_names
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end
end
