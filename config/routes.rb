Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    # ユーザーのdevise
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    # ゲストログイン用
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    # 管理者のdevise
    sessions: "admin/sessions"
  }

  scope module: :public do
    # ユーザーのルーティング
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

    resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
      resource :group_users, only: [:create, :destroy]
      get "new/mail" => "groups#new_mail"
      get "send/mail" => "groups#send_mail"
    end 
  end

  namespace :admin do
    # 管理者のルーティング
    root "homes#top"
    resources :users, only: [:index, :show, :edit, :destroy, :update]
    resources :health_records, only: [:index, :show, :destroy] do
      resources :health_record_comments, only: [:index, :show, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
