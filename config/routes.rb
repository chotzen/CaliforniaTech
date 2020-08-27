Rails.application.routes.draw do
  namespace :admin do
    get 'feature_slots/index'
    get 'feature_slots/update'
  end
  get 'authors/show'
    get 'password_resets/new'
    get 'password_resets/edit'

    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
    get 'tags/:tag', to: 'articles#index', as: :tag

    resources :sessions
    resources :password_resets,     only: [:new, :create, :edit, :update]
    resources :authors, only: [:show]

    resources :articles, only: [:index, :show] do
      get 'page/:page', action: :index, on: :collection
    end

    resources :short_articles, only: [:index, :show], controller: :articles do
      get 'page/:page', action: :index, on: :collection
    end

    # Admin namespace
    namespace :admin do
      resources :articles do
        get :autocomplete_tag_name, on: :collection
        post :toggle_publish#, on: :member
        post :toggle_feature#, on: :member
      end
      resources :authors
      resources :pictures, only: [:create, :update, :destroy]
      resources :users
      resources :feature_slots, only: [:index, :update]
      root :to => 'articles#index'
    end

    root :to => 'articles#index'

end
