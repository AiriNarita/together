class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def profile
    @user = User.find(params[:user_id])
    if @user.blank?
      flash[:notice] = "User is not found"
    end
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

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :introduction, :image)
  end
end
