Rails.application.routes.draw do
  # resources :dogs
  resources :tickets

  get 'spa_tickets', to: 'tickets#spa_index', as: 'spa_tickets'
  post 'tickets/spa_create', to: 'tickets#spa_create', as: 'spa_create_ticket'
  post 'tickets/:id/spa_edit', to: 'tickets#spa_edit', as: 'spa_edit_ticket'
  post 'tickets/:id/spa_cancel', to: 'tickets#spa_cancel', as: 'spa_cancel_ticket'
  patch 'tickets/:id/spa_update', to: 'tickets#spa_update', as: 'spa_update_ticket'
  delete 'tickets/:id/spa_destroy', to: 'tickets#spa_destroy', as: 'spa_destroy_ticket'

  get 'pages/home'
  get 'pages/about'
  get 'pages/async_turbo_frame'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  # get 'spa_tickets', to: 'tickets#spa_index'
  # post 'create_spa_ticket', to: 'tickets#spa_create'

end
