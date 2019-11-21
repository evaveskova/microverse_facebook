# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def index
		@pending_request = current_user.friendships.where(status: false)
		@sent_request_test = Friendship.where(friend: current_user,
      inverse: false, status: false)
		@friendship = Friendship.new
	end

  # rubocop:disable Style/IdenticalConditionalBranches
  def create
    if params[:friendship][:pending_request_id]
      @request_maker = User.find(params[:friendship][:friend])
      @pending_friend_request = Friendship.find(params[:friendship][:pending_request_id])
      @request = Friendship.find_by(user_id: @pending_friend_request.friend_id,
        friend_id: @pending_friend_request.user_id)
      change_friendship_status(@pending_friend_request, @request_maker, @request)
    elsif params[:friendship][:pending_request_id].nil?
      @friend = User.find(params[:friendship][:friend])
      @list_request_senders = User.request_senders(current_user)
      unless current_user.friends.include?@friend
        add_friends(@friend)
        flash[:success] = "friend request has been sent"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:success] = "can't duplicate friend request"
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.status == false
      @friendship.destroy
      flash[:info] = "Friend request has been deleted"
      redirect_back(fallback_location: root_path)
    else
      @friendship.destroy
      flash[:info] = "#{@friend_name} has been unfriended"
      @friend_name = @friendship.friend.first_name
      redirect_back(fallback_location: root_path)
    end
  end
  # rubocop:enable Style/IdenticalConditionalBranches

  private

  def friendship_params
    params.require(:friendship).permit(:friend, :pending_request_id, :status)
  end

  def add_friends(friend)
    current_user.friends << friend
  end


  def un_friend(friend)
    current_user.friends.delete(friend)
  end

  def is_friend(friend)
    current_user.friends.include?friend
  end

  def send_friend_request(friend)
    current_user.friends << friend
    friend.friends << current_user
  end

  def change_friendship_status(pending_friend_request, request_maker, request)
    pending_friend_request.update_attributes(status: true)
    request.update_attributes(status: true)
    flash[:success] = "you have accepted a friend request from #{@request_maker.first_name}"
    redirect_back(fallback_location: root_path)
  end
end
