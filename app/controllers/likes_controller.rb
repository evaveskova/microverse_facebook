class LikesController < ApplicationController
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
end
