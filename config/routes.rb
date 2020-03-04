Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      post 'timelogs/plan_my_day' => 'timelogs#plan_my_day'
      resources :timelogs
      post 'tag_taggables/batch_ensure_tags' => 'tag_taggables#batch_ensure_tags'
      resources :tag_taggables
      resources :memes
      get 'tags/hierarchy' => 'tags#hierarchy'
      get 'tags/leaves' => 'tags#leaves'
      resources :tags
      resources :vocabularies
      resources :listers
      patch 'profile' => 'profile#update'
      resources :contexts
      resources :challenges
      resources :entries
      resources :exercises
      resources :groups
      resources :progressions
      resources :session_progressions
      get 'sessions/todays' => 'sessions#todays'
      resources :sessions
      resources :timelogs
      resources :training_sessions
      resources :trainings
    end
  end

  # Everything else goes to spa. TODO: Use app/javascript/spa/raw_routes.coffee to draw something more secure
  get 'furniturer' => 'standalone#furniturer'
  get '*all' => 'spa#index'
  root 'spa#index'
end
