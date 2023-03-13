class SearchesController < ApplicationController
  def search
    @content = params[:content]
    @model = params[:model]
    @method = params[:method]

    # 検索ワードが空の場合は何もしない
    return if @content.blank?

    @results = Search.search_all_models(@content, @model, @method)

    render "searches/search"
  end
end
