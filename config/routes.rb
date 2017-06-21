Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations'}
  authenticate :user do
    resources :users
    root to: 'games#index'
    get "toggle_staff" => 'users#toggle_staff', :as => :toggle_staff
    get "/add_purcharse" => "purcharses#addPurcharse"
    get "/remove_purcharse" => "purcharses#removePurcharse"
  end
  resources :games
  root to: 'games#index'
end
