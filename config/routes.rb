Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  # URLから/publicを取り除くために"scope module"を使用
  scope module: :public do
    root "homes#top"
    get "home/about" => "homes#about", as: "about"
    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      member do
        get :followings, :followers
      end
      member do
        get :favorites
      end
    end

    resources :health_records, only: [:index, :new, :show, :create, :edit, :destroy, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :health_record_comments, only: [:create, :edit, :destroy]
    end
    get "search", to: "searches#search"
    get "search_tag" => "health_records#search_tag"
    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
      get "new/mail" => "groups#new_mail"
      get "send/mail" => "groups#send_mail"
    end
  end
  
  # 管理者側は/adminをURLに組み込みわかりやすくするため"namespace"を使用
  namespace :admin do
    root "homes#top"
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :health_records, only: [:index, :edit, :destroy]
    resources :health_record_comments, only: [:index, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :record_tags, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end
end
