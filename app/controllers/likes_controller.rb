class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(user_id: @user.id, post_id: @post.id)
    return unless @like.save

    redirect_to user_posts_path(@user.id, @post)
  end
end
