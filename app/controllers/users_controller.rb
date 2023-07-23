class UsersController < ApplicationController
  # Placeholder action for all users page
  def index
    @users = User.distinct
  end

  # Placeholder action for a single user page
  def show
    @user = User.find(params[:id])
    @view_posts = params[:view_posts] == 'true'

    return unless @view_posts

    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
    @recent_comments = {}
    @posts.each do |post|
      @recent_comments[post.id] = post.comments.order(created_at: :desc).limit(5)
    end
    render 'posts'
  end

  # New action for all users page
  def all_users
    @users = User.all
  end
end
