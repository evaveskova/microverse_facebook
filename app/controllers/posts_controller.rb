# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_for_edit_post, only: %i[edit]
  before_action :check_user_for_delete_post, only: %i[destroy]

  def index
    @posts = Post.visible_to_user current_user
    @post = Post.new
    @main_user = User.find(current_user.id)
    @comment = Comment.new
    @like = Like.new
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    flash[:success] = 'Post has been successfully created'
    redirect_back(fallback_location: root_path)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = 'post has been updated'
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = 'post has been deleted successfully'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def check_user_for_edit_post
    @user = Post.find(params[:id]).author
    unless @user == current_user
      flash[:danger] = 'please you are not permited to edit this post'
      redirect_back(fallback_location: root_path)
    end
  end

  def post_params
    params.require(:post).permit(:id, :content)
  end

  def check_user_for_delete_post
    @user = Post.find(params[:id]).author
    unless @user == current_user
      flash[:danger] = 'please you are not permited to delete this post'
      redirect_back(fallback_location: root_path)
    end
  end
end
