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
      get 'sessions/todays' => 'sessions#today'
      resources :sessions
      resources :training_sessions
      resources :trainings
    end
  end

  get '.well-known/acme-challenge/rWJMshGiEIOoSHdhAuZXU7XLjLxwZgonfp-ogI5vJsA' => 'spa#acme'

  # Everything else goes to spa. TODO: Use app/javascript/spa/raw_routes.coffee to draw something more secure
  get "*all" => 'spa#index'
  root 'spa#index'
end
