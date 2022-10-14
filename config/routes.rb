Rails.application.routes.draw do
  get 'businesses/index'
  get 'businesses/destroy'
  resources :messages
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :businesses, path: 'businesses', controllers: {
    sessions: 'businesses/sessions',
    registrations: 'businesses/registrations'
  }

  devise_scope :user do
    authenticated :user do
      namespace :categories do
        get "index", as: :authenticated_root
      end
    end
  end

  devise_scope :business do
    authenticated :business do
      namespace :businesses do
        get 'dashboard/index', as: :authenticated_root
        get 'dashboard/get_companies'
        get 'dashboard/get_reviews'
      end
    end
  end

  get 'about/index'
  get 'users/index'
  get 'users/show'
  get 'users/destroy'
  get "companies/top"
  get 'dashboard/show'
  get "companies/admin_companies"
  get "search", to: "categories#search"
  resources :categories
  resources :packages
  resources :notifications, only: [:index]
  
  resources :companies, only: %i[index new create show destroy update] do 
    resources :reviews, only: %i[new create destroy edit update]
  end
  root "categories#index"
end
