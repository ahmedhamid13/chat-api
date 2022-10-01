# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :applications, controller: 'system_applications' do
        resources :chats do
          resources :messages
        end
      end
    end
  end

  scope '/admin' do
    mount Sidekiq::Web => 'sidekiq', as: 'sidekiq'
    mount RailsPerformance::Engine, at: 'site_performance', as: 'site_performance'
  end
end
