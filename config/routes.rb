Rails.application.routes.draw do
  root 'plates#index'
  post "detective" => "plates#detective"
  resources :plates
  resources :blacklists
end
