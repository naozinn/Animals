Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get "/about" => "homes#about", as: "about"

  resources :animals, only: [:index, :show, :create, :edit, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :animal_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :create, :edit, :update]
  get '/search' => 'searches#search'



  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }
end
