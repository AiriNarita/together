class SearchesController < ApplicationController
  before_action :authenticate_user!, except: [:search]

  def search
    @user = User.all

    @content = params[:content]
    @model = params[:model] || "nil"
    @method = params[:method]

    # 検索ワードが空の場合は何もしない
    return if @content.blank?

    # Array
    @results = Search.search_all_models(@content, @model, @method)

    render "searches/search"
  end
end
