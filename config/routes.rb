Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'exercises#index'
  resources :exercise
  devise_for :users
end
