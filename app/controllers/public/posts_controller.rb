class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    if params[:commit] == "下書き保存"
      @post = current_user.posts.build(post_params)
      if @post.save_draft
        redirect_to drafts_posts_path
      else
        render :new
      end
    else
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to post_path(@post)
      else
        render :new
      end
    end
  end

  def drafts
    # 本文に"Ruby"という文字列が含まれ、かつ公開ステータスである投稿を取得
    @published_posts = Post.where(user_id: current_user.id).where(post_status: :published).order(created_at: :desc)
    @draft_posts = Post.where(user_id: current_user.id).where(post_status: :draft).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      if params[:commit] == "下書き保存"
        @post.update(post_status: :draft)
        redirect_to posts_path, notice: "下書きを保存しました。"
      else
        @post.update(post_status: :published)
        redirect_to @post, notice: "投稿を更新しました。"
      end
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_status)
  end
end
