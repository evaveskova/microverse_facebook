# frozen_string_literal: true

class Friendship < ApplicationRecord
  after_create :create_inverse_relationship
	after_destroy :destroy_inverse_relationship
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true, uniqueness: { scope: :friend }
  validates :friend, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true, uniqueness: {scope: :friend}
  validate :not_self

private

  def create_inverse_relationship
      friend.friendships.create(friend: user, inverse: true)
  end

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship&.destroy
  end

end
