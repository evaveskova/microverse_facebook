class CommentsController < ApplicationController
	def create 
		@comment = current_user.comments.build(comment_params)
		if @comment.save 
			flash[:success] = "comment created"
			redirect_to root_path
		else
			flash[:danger] = "could not be saved"
			redirect_back(fallback_location: root_path)
		end 
	end 

	def edit
		@comment = Comment.find(params[:id])
	end 
end
