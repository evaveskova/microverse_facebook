# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(first_name: 'againfirstname',
      last_name: "againlastname",
      email: 'asuser1@example.com',
      password: "password",
      gender: "female",
      birthday: "2019-11-06"
      )
    @post = @user.posts.new(content: "this is my first post")
  end

  context 'Post model' do
    it 'post must be valid' do
      expect(@post).to be_valid
    end

    it 'content must be present' do
      @post.content = '  '
      expect(@post).not_to be_valid
    end

    it "author must be present" do
      @post.author = nil
      expect(@post).not_to be_valid
    end
  end
end
