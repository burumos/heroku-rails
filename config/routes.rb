Rails.application.routes.draw do
  root 'top#index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'nico' => 'nico#index'
  scope 'nico', as: 'nico' do
    get 'search' => 'nico#search'
    post 'condition' => 'nico#create_condition'
    delete 'condition/:id' => 'nico#destroy_condition'
  end
end
