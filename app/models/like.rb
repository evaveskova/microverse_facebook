class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :author, class_name: 'User', foreign_key: "author_id"
  validates :author_id, presence: true
  validates :likeable_type, presence: true
  validates :likeable_id, presence: true
end
