Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
  root to: 'homes#top'
  end

  root to: 'homes#top'
  get "/about" => "homes#about", as: "about"
  
  resources :animals, only: [:index, :show, :create, :edit, :destroy, :update]
  resources :users, only: [:index, :show, :create, :edit, :update]

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }
end
