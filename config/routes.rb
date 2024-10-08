Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "projects#index"

  namespace :users do
    resource :registration, only: %i[new create]
    resource :session, only: %i[new create destroy]
  end

  resources :projects
end
