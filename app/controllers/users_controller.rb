class UsersController < ApplicationController
  # Placeholder action for all users page
  def index
    @users = User.distinct
  end

  # Placeholder action for a single user page
  def show
    @user = User.find(params[:id])
    @view_posts = params[:view_posts] == 'true'
  end

  # Placeholder action for all posts by a given user
  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)

    @recent_comments = {}
    @posts.each do |post|
      @recent_comments[post.id] = post.comments.order(created_at: :desc).limit(5)
    end
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
