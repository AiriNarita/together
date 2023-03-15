class Admin::UsersController < ApplicationController
  def show
    debugger
    @user = User.find(params[:id])
  end

  # user_status管理

  def edit
    @user = User.find(params[:id]) #編集したいuserのIDを取得
  end

  def update
    @user = User.find(params[:id])
    if params[:user] && params[:user][:user_status] == true
      @user.user_status = true
    else
      @user.user_status = false
    end

    if @user.save
      redirect_to admin_user_path(@user)
    else
      render "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_status).transform_values { |value| value == "true" }
  end
end
