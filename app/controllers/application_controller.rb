class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
end
