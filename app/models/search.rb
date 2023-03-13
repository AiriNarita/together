class Search < ApplicationRecord
  def self.search_all_models(content, model, method)
    if model.present?
      if model == "user"
        User.search_content(content, method)
      elsif model == "post"
        Post.search_content(content, method)
      elsif model == "event"
        Event.search_content(content, method)
      elsif model == "hashtag"
        Hashtag.search_content(content, method)
      end
    else
      results = []
      results << User.search_content(content, method)
      results << Post.search_content(content, method)
      results << Event.search_content(content, method)
      results << Hashtag.search_content(content, method)
      results.flatten
    end
  end
end
