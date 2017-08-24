Rails.application.routes.draw do
  resources :queries
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  authenticated :user do
    root 'queries#index', as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :results
end
