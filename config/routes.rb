Rails.application.routes.draw do
  get 'about/index'
  get 'users/index'
  get 'users/show'
  get 'users/destroy'
  get "companies/top"
  get "companies/admin_companies"
  resources :categories
  devise_for :users
  resources :companies, only: %i[index new create show destroy update] do 
    resources :reviews, only: %i[new create destroy edit update]
  end
  root "categories#index"
end
