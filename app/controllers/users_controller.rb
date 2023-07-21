class UsersController < ApplicationController
  # Placeholder action for all users page
  def index
    @users = User.distinct
  end

  # Placeholder action for a single user page
  def show
    @user = User.find(params[:id])
  end

  # Placeholder action for all posts by a given user
  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end

  # Placeholder action for a single post page for a given user
  def post_show
    @user = User.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  # New action for all users page
  def all_users
    @users = User.all
  end
end
