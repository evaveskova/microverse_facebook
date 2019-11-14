class CommentsController < ApplicationController
	before_action :check_user_for_edit_comment, only: %i[ edit ]
	before_action :check_user_for_delete_comment, only: %i[ destroy ]
	
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

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			flash[:success] = "post has been updated"
      		redirect_to root_path
		end
	end 

	def destroy
		@comment = Comment.find(params[:id])
		if @comment.destroy
			flash[:info] = "comment has been successfully deleted"
			redirect_back(fallback_location: root_path)
		end 
	end

	private

	def comment_params
		params.require(:comment).permit(:content, :post_id)
	end 

	def check_user_for_delete_comment
      @user = Comment.find(params[:id]).author
      unless @user == current_user
        flash[:danger] = "please you are not permited to delete this post"
        redirect_back(fallback_location: root_path)
      end
    end 

	def check_user_for_edit_comment
      @user = Comment.find(params[:id]).author
      unless @user == current_user 
        flash[:danger] = "please you are not permited to edit this post"
        redirect_back(fallback_location: root_path)
      end 
    end 

end
