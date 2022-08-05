Rails.application.routes.draw do
  root 'top#index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'nico' => 'nico#index'
  namespace :nico do
    # get 'games' => 'games@index'
    get :search
  end
end
