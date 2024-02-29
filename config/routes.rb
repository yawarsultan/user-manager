Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#index'

  resources :teams do
    get :assign_members
    post :save_members
    resources :roles
    resources :users do 
      get :assign_roles
      post :save_roles
    end
  end
end
