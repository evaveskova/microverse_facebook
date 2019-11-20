# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
		if params[:friendship][:pending_request_id]
			@pending_friend_request =Friendship.find(params[:friendship][:pending_request_id])
			change_friendship_status(@pending_friend_request)
			@request_maker = User.find(params[:friendship][:friend])
			accept_friend_request(@request_maker)
		else
			@friend = User.find(params[:friendship][:friend])
			unless current_user.friends.include?@friend
				add_friends(@friend)
				flash[:success] = "friend request has been sent"
				redirect_back(fallback_location: root_path)
			end
		end
	end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.status == false
      @friendship.destroy
      flash[:info] = "Friend request has been deleted"
      redirect_back(fallback_location: root_path)
    else
      @friendship_two = Friendship.where(user: @friendship.friend, friend: current_user)
      @friend_name = @friendship.friend.first_name
      @friendship.destroy
      @friendship_two.each do |f|
        f.destroy
      end 
      flash[:info] = "#{@friend_name} has been unfriended"
      redirect_back(fallback_location: root_path)
    end 
  end 

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
  end

  def change_friendship_status(pending_friend_request)
    pending_friend_request.update_attributes(status: true)
  end 

  def accept_friend_request(request_maker)    
    current_user.friendships.create(friend: request_maker, status: true)
    flash[:success] = "you have accepted a friend request from #{request_maker.first_name}"
    redirect_back(fallback_location: root_path)
  end  
end
