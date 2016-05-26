Rails.application.routes.draw do

  root 'tags#index'

  resources :authors
  resources :poems
  resources :short_stories
  resources :tags

end
