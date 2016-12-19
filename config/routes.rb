Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users

  resources :users do
    member do
      get :edit_email
      get :edit_password
    end
  end

  resources :distributors
  resources :customers do
    resources :licenses do
      member do
        put :restore
        get :download, defaults: { format: :text }
      end
    end
    member do
      put :restore
    end
  end

  resources :products do
    resources :downloads do
      member do
        get :download
      end
    end
  end

  resources :license_pools

  namespace :communication do
    get '', to: redirect('communication/call')
    get :call
    post :ring
    post :hangup
    get :terminated
    get :join
  end

  scope :me do
    resources :users, as: :my_account, only: [:show, :edit, :update] do
      member do
        get :edit_email
        get :edit_password
      end
    end
  end

  namespace :dashboards do
    get :index
    get :graph
  end

  root 'application#welcome'
end
