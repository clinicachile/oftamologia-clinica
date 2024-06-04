Rails.application.routes.draw do
  devise_for :users

  namespace 'admin' do
    get 'dashboard/', to: 'dashboard#index'
    resources :pacients do
      get :pacient_appointment, on: :collection
      post :pacient_appointment_post, on: :collection
    end
    resources :appointments
    get 'imports/create_pdf'
    get '/preview/:id', to: 'pdf#preview', as: :preview
  end

  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/mostrar-producto', to: 'application#mostrar_producto'

  # Defines the root path route ("/")
  # root "posts#index"
end
