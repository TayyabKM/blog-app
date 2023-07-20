class UsersController < ApplicationController
  # Placeholder action for all users page
  def index
    @users = User.distinct
    @placeholder_text = 'Placeholder text for all users'
  end

  # Placeholder action for a single user page
  def show
    @user = User.find(params[:id])
  end

  # Placeholder action for all posts by a given user
  def posts
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  # Placeholder action for a single post page for a given user
  def post_show
    @post = Post.find(params[:post_id])
  end
end
