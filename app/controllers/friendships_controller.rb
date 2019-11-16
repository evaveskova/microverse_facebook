class FriendshipsController < ApplicationController
  def create
        @friend = User.find(params[:friendship][:friend])
        unless current_user.friends.include?@friend
            add_freinds(@friend)
            flash[:success] = "#{@friend.first_name} has been added to your friend list"
            redirect_back(fallback_location: root_path)
        end
    end
end
