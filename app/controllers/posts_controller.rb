class PostsController < ApplicationController
  # Placeholder action for all posts by a given user
  def index
    @posts = Post.all
    @placeholder_text = 'Placeholder text for all posts by a given user'
  end

  # Placeholder action for a single post page
  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # Handle the case where the post with the given ID is not found
    flash[:error] = 'Post not found'
    redirect_to posts_path
  end
end
