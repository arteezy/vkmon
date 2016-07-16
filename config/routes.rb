Rails.application.routes.draw do
  root to: 'pages#home'
  resources :watchers
  get 'status', to: 'pages#status'
end
