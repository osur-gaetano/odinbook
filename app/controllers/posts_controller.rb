class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy like unlike]
  def index
    @accepted_followers = current_user.followers
    @accepted_followings = current_user.followings

    @user_posts = current_user.posts
    @follower_posts = @accepted_followers.each_with_object([]) { |follower, results| results << follower.posts }
    @following_posts = @accepted_followings.each_with_object([]) { |following, results| results << following.posts }
    @feed = [ @user_posts, @follower_posts, @following_posts ].flatten.sort_by { |post| post.created_at }.reverse
  end

  def show
    @likes_count = @post.count_likes
  end

  def new
    @post = Post.new
  end

  def create
    @author = current_user
    @post = Post.new(post_params)
    @post.author = @author

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to root_path, status: :see_other, notice: "Post was successfuly deleted!"
  end

  def like
    @post.add_like(current_user.id)
    redirect_to @post
  end

  def unlike
    @like = @post.likes.find_by(user_id: current_user.id)
    @like.destroy! unless @like.nil?
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end


  def post_params
    params.require(:post).permit(:content, :title, :user_id)
  end
end
