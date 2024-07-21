Rails.application.routes.draw do
  root to: 'zip_codes#index'

  get 'search', to: 'zip_codes#search'
end
