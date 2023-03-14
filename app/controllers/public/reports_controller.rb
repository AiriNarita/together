class Public::ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)

    @report.reporter.id = current_user.id
    @report.reported.id = @user.id

    if @report.save
      redirect_to my_page_users_path
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end
end
