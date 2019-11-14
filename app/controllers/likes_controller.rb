class LikesController < ApplicationController
  before_action(only: [:create]) { check_liker(current_user) }

  def create
    @like = current_user.likes.build(like_params)
      if @like.save
            flash[:success] = "liked a #{@like.likeable_type}"
            redirect_back(fallback_location: root_path)
      end
    end

    private

  def like_params
      params.require(:like).permit(:likeable_type, :likeable_id)
  end

  def check_liker(current_user)
    @liking = Like.where(author_id: current_user.id,
        likeable_type: params[:like][:likeable_type],
        likeable_id: params[:like][:likeable_id])
        if @liking.exists?
          @liking.first.destroy
            redirect_back(fallback_location: root_path)
        end
    end
end
