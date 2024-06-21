# config/routes.rb
Rails.application.routes.draw do
  root 'main#index'
  get 'teacher', to: 'teacher#index'
  get 'vildanov', to: 'vildanov#index'
  get 'cathedra', to: 'cathedra#index'
  get 'davletshin', to: 'davletshin#index'
  get 'students', to: 'students#index'
  get '/allpub', to: 'allpub#index'
  get '/nirs', to: 'nirs#index'
  get 'nirs/new', to: 'nirs#new', as: 'new_nir' # убедитесь, что этот маршрут настроен
  get 'studpub', to: 'studpub#index'
  post '/cathedra/select', to: 'cathedra#select_cathedra', as: 'cathedra_select'
  resources :cathedra, only: [:index, :edit, :update, :destroy]
  resources :nirs, only: [:index, :new, :edit, :create, :update, :destroy]
  resources :authors, only: [:new, :create]
  resources :vildanov, only: [:index]
  resources :studpub, only: [:index]
  resources :cathedra, only: [:index] do
    member do
      get 'edit'
      patch 'update'
      delete 'destroy'
    end
  end
end
