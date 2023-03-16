class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  # user_status管理

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_reports_path
    else
      render "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_status)
  end
end
