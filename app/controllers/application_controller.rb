class ApplicationController < ActionController::Base
  #before_action :authenticate_user!, except: [:top, :about]
  before_action :authenticate_admin!, if: -> { request.path =~ /^\/admin/ }
end
