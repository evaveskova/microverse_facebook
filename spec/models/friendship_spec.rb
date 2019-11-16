# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:roy) { FactoryBot.create(:user) }
  let(:eva) { FactoryBot.create(:user) }

  it 'should establish friendship between 2 users' do
    friendship = roy.friendships.build(friend: eva)

    expect(friendship).to be_valid
  end

  it 'user should be present' do
    friendship = Friendship.new(user: roy, friend: eva)
    friendship.user = nil

    expect(friendship).not_to be_valid
  end

  it 'friend should be present' do
    friendship = Friendship.new(user: roy, friend: eva)
    friendship.friend = nil

    expect(friendship).not_to be_valid
  end

  it 'should prevent duplicate friendship entries' do
    roy.friendships.create(friend: eva)
    friendship = roy.friendships.build(friend: eva)

    expect(friendship).not_to be_valid
  end
end
