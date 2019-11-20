# frozen_string_literal: true

class ApplicationController < ActionController::Base
	helper_method :friend_request_count

	def friend_request_count
		Friendship.where(friend: current_user, status: false).count		
	end	 

	private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_registration_path 
  end

	
end
