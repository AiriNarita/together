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
      resources :post_comments, only: [:create, :destroy]
      resources :post_hashtags, only: [:create, :destroy]
    end
    resources :hashtags, only: [:create, :index, :show]
    resource :users do
      # member do
      #   get :follows, :followers
      # end
      get ":user_id/follows" => "users#follows", as: "follows"
      get ":user_id/followers" => "users#followers", as: "followers"
      post "profile/:user_id/relation" => "relations#create", as: "relations_post"
      delete "profile/:user_id/relation" => "relations#destroy", as: "relation_delete"

      get "my_page" => "users#show"
      get "profile/:user_id" => "users#profile", as: "profile"
      # added
      post "profile/:user_id/report" => "reports#create", as: "profile_report"
      get "profile/:user_id/report/new" => "reports#new", as: "profile_reports_new"
      get "information/edit" => "users#edit"
      patch "information" => "users#update"
    end

    resources :events do
      collection do
        get "myevent"
      end
      resources :attendees, only: [:create, :show, :edit, :update, :destroy]
    end
  end

  get "/search", to: "searches#search"

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
    resources :users, only: [:index, :show, :edit, :update]
    resources :events, only: [:index, :show]
    resources :reports, only: [:index, :show, :update]
  end
end
