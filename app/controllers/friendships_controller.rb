# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:friendship][:friend])
    unless current_user.friends.include? @friend
      add_friends(@friend)
      flash[:success] = "#{@friend.first_name} has been added to your friend list"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friend = Friendship.find(params[:id]).friend
    if current_user.friends.include? @friend
      friend_name = @friend.first_name
      unfriend(@friend)
      flash[:info] = "#{friend_name} was successfully unfriended"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend)
  end

  def add_friends(friend)
    current_user.friends << friend
  end

  def unfriend(friend)
    current_user.friends.delete(friend)
  end
end
