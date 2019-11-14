# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @user = User.create(first_name: 'againfirstname',
                        last_name: 'againlastname',
                        email: 'asuser1@example.com',
                        password: 'password',
                        gender: 'female',
                        birthday: '2019-11-06')
    @post = @user.posts.create(content: 'this is my first post')
    @comment = @user.comments.new(post_id: @post.id, content: 'this is my comment')
  end

  context 'Comment Associations and validations' do
    it 'All associations must be present' do
      expect(@comment).to be_valid
    end

    it 'comment content must be present' do
      @comment.content = ''
      expect(@comment).not_to be_valid
    end

    it 'comment author must be present' do
      @comment.author = nil
      expect(@comment).not_to be_valid
    end

    it 'comment post must be present' do
      @comment.post = nil
      expect(@comment).not_to be_valid
    end
  end
end
