Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/terms', to: 'welcome#terms'
  resources :schedules do
    get :daily, on: :collection
  end
  resources :users, only: :destroy
end
