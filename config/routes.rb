Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'exercises#index'
  resources :exercises
  resources :users, only: :create
  devise_for :users
  resources :submissions

  get 'grades', to: "submissions#grades"
  get 'gradebook', to: "submissions#gradebook"
  get 'mass_edit', to: "exercises#mass_edit"
end
