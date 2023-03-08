class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:commit] == "下書き保存"
      @post.save_draft
      redirect_to posts_path
    else
      if @post.save
        redirect_to post_path(@post)
      else
        render :new
      end
    end
  end

  def drafts
    @drafts = current_user.posts.draft
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_status)
  end
end
