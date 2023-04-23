class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :author_user, only: [:edit]
  # editには入れなくしたいのでonlyで限定
  # before_actionも上から順に読み込まれるよ。上の項目を通過するものなら下の条件。

  def new
    @post = Post.new
  end

  def create

    # 下書き保存ボタンを押されたら
    if params[:commit] == "下書き保存"
      @post = Post.create(post_params.merge(user_id: current_user.id))
      if @post.save_draft
        save_hashtags
        redirect_to drafts_posts_path
      else
        render :new
      end
    else
      # 投稿ボタンが押されたら
      @post = Post.create(post_params.merge(user_id: current_user.id))
      if @post.save
        save_hashtags
        redirect_to post_path(@post)
      else
        render :new
      end
    end
  end

  def drafts
    @published_posts = Post.where(user_id: current_user.id).where(post_status: :published).order(created_at: :desc)
    @draft_posts = Post.where(user_id: current_user.id).where(post_status: :draft).order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new

    @post_comments = PostComment.where(post_id: params[:id]).order(created_at: :desc)
    @post_hashtags = @post.hashtags
  end

  def index
    @post_comment = PostComment.new
    params[:sort] = params[:sort].blank? ? "latest" : params[:sort]
    case params[:sort]
    when "latest"
      @posts = Post.includes(:hashtags)
                   .order(created_at: :desc)
                   .visible.page(params[:page]).per(8)
    when "favorites"
      @posts = Post.includes(:hashtags)
                   .left_joins(:favorites)
                   .select("posts.*, COUNT(favorites.id) AS favorites_count")
                   .group("posts.id")
                   .order("favorites_count DESC")
                   .visible.order(favorites_count: :desc).page(params[:page]).per(8)
    end
  end

  def edit
    @post = Post.find(params[:id])
    @isDraft = @post.draft?
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      tag_list = params[:post][:hashtag_name].split(nil)
      if params[:commit] == "下書き保存"
        @post.update(post_status: :draft)
        update_hashtags
        redirect_to posts_path, notice: "下書きを保存しました。"
      else
        @post.update(post_status: :published)
        update_hashtags
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
    params.require(:post).permit(:title, :body, :post_status, :post_image)
  end

  def save_hashtags
  end

  def update_hashtags
    # 中間テーブルのPost Idで探して出たデータ全てを消す→Clean！
    PostHashtag.where(post_id: @post.id).destroy_all
    sent_tags = params[:post][:hashtag_name].scan(/#\w+/).map(&:strip).uniq.map(&:downcase)

    # 既存のハッシュタグを取得する
    existing_tags = Hashtag.where(hashtag_name: sent_tags)

    existing_tags.each do |tag|
      post_hashtag = PostHashtag.where(hashtag_id: tag.id, post_id: @post.id)
      PostHashtag.create(hashtag_id: tag.id, post_id: @post.id)
    end

    # 既存のハッシュタグと重複していないタグを追加する
    new_tags = sent_tags - existing_tags.pluck(:hashtag_name)
    new_tags.each do |tag_name|
      tag = Hashtag.create(hashtag_name: tag_name)
      PostHashtag.create(hashtag_id: tag.id, post_id: @post.id)
    end
  end

  def save_hashtags
    # 重複を削除する
    sent_tags = params[:post][:hashtag_name].scan(/#\w+/).map(&:strip).uniq.map(&:downcase)

    # 既存のハッシュタグを取得する
    existing_tags = Hashtag.where(hashtag_name: sent_tags)

    existing_tags.each do |tag|
      post_hashtag = PostHashtag.where(hashtag_id: tag.id, post_id: @post.id)
      PostHashtag.create(hashtag_id: tag.id, post_id: @post.id)
    end

    # 既存のハッシュタグと重複していないタグを追加する
    new_tags = sent_tags - existing_tags.pluck(:hashtag_name)
    new_tags.each do |tag_name|
      tag = Hashtag.create(hashtag_name: tag_name)
      PostHashtag.create(hashtag_id: tag.id, post_id: @post.id)
    end
  end

  #user　編集制限validation (投稿のidに関連するuseridとログイン中のidが同じな時以外で)
  def author_user
    unless Post.find(params[:id]).user.id.to_i == current_user.id
      redirect_to posts_path
    end
  end
end
