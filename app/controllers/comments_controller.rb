class CommentsController < ApplicationController
  before_action :set_post, only: %i[ create ]

  def new
    @comment= @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @post
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "You have edited this comment"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to root_path, status: :see_other, notice: "You have deleted this comment"
  end


  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
