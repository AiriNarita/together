class Public::ReportsController < ApplicationController
  def new
    @reported = Reported.new
  end

  def create
    @reported = Reported.new(reported_params)

    if @reported.save
      flash[:notice] = "通報が送信されました。"
      redirect_to my_page_users_path
    else
      render :new
    end
  end

  def show
  end

  private

  def reported_params
    params.require(:reported).permit(:reporter_id, :content)
  end
end
