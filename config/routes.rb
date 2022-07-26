Rails.application.routes.draw do
  root 'top#index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  scope 'nico', as: 'nico' do
    root 'nico/top#index'
    get 'search' => 'nico/search#index'
    post 'condition' => 'nico/condition#create'
    delete 'condition/:id' => 'nico/condition#destroy'
    get 'game' => 'nico/game#index'
    post 'game' => 'nico/game#create'
    get 'vocaloid' => 'nico/vocaloid#index'
    get 'utau' => 'nico/utau#index'
  end
end
