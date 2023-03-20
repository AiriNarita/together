class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:profile]

  def show
    @user = current_user
    @my_posts = @user.posts.page(params[:page]).per(8)
    @my_events = Event.where(creator_id: params[:user_id]).page(params[:page]).per(8)
    @my_likes = Post.where(id: @user.favorites.pluck(:post_id)).page(params[:page]).per(8)

    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def profile
    @user = User.find(params[:user_id])
    if @user.blank?
      flash[:notice] = "User is not found"
    end
    @my_posts = @user.posts.page(params[:page]).per(8)
    @my_events = Event.where(creator_id: params[:user_id]).page(params[:page]).per(8)
    # @my_likes = @user.favorites.includes(:post).map(&:post)
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to my_page_users_path(@user)
    else
      render :edit
    end
  end

  def follows
    @user = User.find(params[:user_id])
    @users = @user.following_user.page(params[:page]).per(3).reverse_order

    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.follower_user.page(params[:page]).per(3).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :introduction, :image)
  end
end
