Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root "homes#top"
    get "home/about" => "homes#about", as: "about"
    resources :health_records, only: [:index, :new, :show, :create, :edit, :destroy, :update] do 
      resource :favorite, only: [:create, :destroy]
      resources :health_record_comments, only: [:create, :edit, :destroy]
    end 
  end

  namespace :admin do
    root "homes#top"
    resources :users, only: [:index, :show, :edit, :destroy, :update]
    resources :health_records, only: [:index, :show, :destroy] do
      resources :health_record_comments, only: [:index, :show, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
