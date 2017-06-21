Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations'}
  authenticate :user do
    resources :users
    root to: 'games#index'
    get "toggle_staff" => 'users#toggle_staff', :as => :toggle_staff
  end
  resources :games
  root to: 'games#index'
end
