class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_for_edit_post, only: %i[ edit ]

  def index
    @posts = Post.all
    @post = Post.new
    @main_user = User.find(current_user.id)
    
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post has been successfully created"
      redirect_back(fallback_location: root_path)
    else
      render 'posts/index'
    end    
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "post has been updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


    def check_user_for_edit_post
      @user = Post.find(params[:id]).author
      unless @user == current_user 
        flash[:danger] = "please you are not permited to edit this post"
        redirect_back(fallback_location: root_path)
      end 
    end

    def post_params
      params.require(:post).permit(:content)
    end

end
