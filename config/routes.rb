Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :challenges
      resources :entries
      resources :exercises
      resources :groups
      resources :progressions
      resources :session_progressions
      resources :sessions
      resources :training_sessions
      resources :trainings
    end
  end

  # Everything else goes to spa. TODO: Use app/javascript/spa/raw_routes.coffee to draw something more secure
  get "*all" => 'spa#index'
  root 'spa#index'
end
