# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(first_name: 'againfirstname',
                        last_name: 'againlastname',
                        email: 'asuser1@example.com',
                        password: 'password',
                        gender: 'female',
                        birthday: '2019-11-06')
    @post = @user.posts.create(content: 'this is my first post')
    @comment = @user.comments.create(post_id: @post.id, content: 'this is my comment')
    @post_like = @user.likes.new(likeable_id: @post.id, likeable_type: 'Post')
    @comment_like = @user.likes.new(likeable_id: @comment.id, likeable_type: 'Comment')
  end

  context 'Like Associations and validations' do
    it 'All associations must be present for like on post' do
      expect(@post_like).to be_valid
    end

    it 'All associations must be present for like on comment' do
      expect(@comment_like).to be_valid
    end

    it 'post must be present' do
      @post_like.likeable_id = nil
      expect(@post_like).not_to be_valid
    end

    it 'comment must be present' do
      @comment_like.likeable_id = nil
      expect(@comment_like).not_to be_valid
    end

    it 'likeable_type must be present' do
      @comment_like.likeable_type = nil
      expect(@comment_like).not_to be_valid
    end
  end
end
