class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    has_many :posts, foreign_key: 'author_id', dependent: :destroy

    validates :first_name, presence: true,  length: { within: 4..20 }
    validates :last_name, presence: true, length: { within: 4..20 }
    validates :email, presence: true, format: Devise.email_regexp
    validates :gender, presence: true, inclusion: { in: %w[male female custom] }
    validates :birthday, presence: true

    before_save :downcase_email
    before_save :capitalize_names
    before_create :gravatar_image_url
end
