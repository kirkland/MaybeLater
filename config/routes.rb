MaybeLater::Application.routes.draw do
  resources :users
  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"
  resources :user_sessions

  resources :tasks do
    member do
      post :update_status
    end
    collection do
      post :reorder
    end
  end

  match 'automatic_create' => "users#automatic_create"

  root :to => 'tasks#index'
end
