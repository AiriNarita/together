Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
                       registrations: "public/registrations",
                       sessions: "public/sessions",
                     }
  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
    resources :posts do
      collection do
        get "drafts"
      end
      resource :favorite, only: [:create, :destroy]
      resources :hashtags, only: [:create, :show]
      resources :post_comments, only: [:create, :destroy]
      resources :post_hashtags, only: [:create, :destroy]
    end
    resource :users, only: [] do
      get "my_page" => "users#show"
      get "information/edit" => "users#edit"
      patch "information" => "users#update"
    end

    resources :events do
      resources :attendees, only: [:create, :destroy]
    end
  end

  get "searches/search", to: "searches#search"

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
                       sessions: "admin/sessions",
                     }

  namespace :admin do
    root to: "homes#top"
    resources :posts do
      resources :comments, only: [:index, :show, :edit, :update, :destroy]
    end
    resources :users, only: [:index, :show]
    resources :events, only: [:index, :show]
  end
end
