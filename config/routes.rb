Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
    end
  end

  # Everything else goes to spa. TODO: Use app/javascript/spa/raw_routes.coffee to draw something more secure
  get "*all" => 'spa#index'
  root 'spa#index'
end
