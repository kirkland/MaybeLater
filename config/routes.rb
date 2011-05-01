MaybeLater::Application.routes.draw do
  resources :users
  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"
  resources :user_sessions

  resources :tasks do
    collection do
      post :reorder
    end
  end

  root :to => 'tasks#index'
end
