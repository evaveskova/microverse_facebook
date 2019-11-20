# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
  	@friendship = Friendship.new
  	@confirmed_friends = User.find_confirmed_friends(current_user)
  	@pending_friends = User.find_pending_friends(current_user)
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
  end
end
