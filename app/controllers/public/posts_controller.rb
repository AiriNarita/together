class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
  end

  def show
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
