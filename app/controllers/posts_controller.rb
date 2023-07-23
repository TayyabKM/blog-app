class PostsController < ApplicationController
  # Placeholder action for all posts by a given user
  def index
    if params[:user_id].present?
      # If 'user_id' is provided, display posts for that specific user
      @user = User.find(params[:user_id])
      @posts = @user.posts.paginate(page: params[:page], per_page: 10)
      # @placeholder_text = "Placeholder text for all posts by #{user.name}"
    else
      # If 'user_id' is not provided, display all posts
      @posts = Post.all.paginate(page: params[:page], per_page: 10)
      # @placeholder_text = 'Placeholder text for all posts'
    end
  end

  # Placeholder action for a single post page
  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # Handle the case where the post with the given ID is not found
    flash[:error] = 'Post not found'
    redirect_to posts_path
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
