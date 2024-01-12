Rails.application.routes.draw do
  get 'analytics', to: 'analytics#index'
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
