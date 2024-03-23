Rails.application.routes.draw do
  
  # ユーザーのdevise
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # ゲストログイン用
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  # 管理者のdevise
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  # ユーザーのルーティング
  scope module: :public do
    # トップページへ遷移
    root "homes#top"
    # アバウトページへ遷移
    get "home/about" => "homes#about", as: "about"
    
    # ユーザー機能
    resources :users, only: [:index, :show, :edit, :update] do
      # フォロー機能
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
    
    # 投稿機能
    resources :health_records, only: [:index, :new, :show, :create, :edit, :destroy, :update] do
      # いいね機能
      resource :favorites, only: [:create, :destroy]
      # コメント機能
      resources :health_record_comments, only: [:create, :edit, :destroy]
    end
    # キーワード検索
    get "search", to: "searches#search"
    # タグ検索
    get "search_tag" => "health_records#search_tag"
    
    # グループ機能
    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
      get "new/mail" => "groups#new_mail"
      get "send/mail" => "groups#send_mail"
    end 
  end

  namespace :admin do
    # 管理者のルーティング
    root "homes#top"
    # ユーザー管理
    resources :users, only: [:index, :edit, :update, :destroy]
    # 投稿管理
    resources :health_records, only: [:index, :edit, :destroy] 
    # コメント管理
    resources :health_record_comments, only: [:index, :destroy]
    # ジャンル管理
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    # タグ管理
    resources :record_tags, only: [:index, :destroy]
    # グループ管理
    resources :groups, only: [:index, :destroy]
  end
end
