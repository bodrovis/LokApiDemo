Rails.application.routes.draw do
  namespace :api do
    resources :callbacks, only: [] do
      collection do
        post 'notify'
      end
    end
  end

  resources :webhooks, only: %i[new create]

  root 'webhooks#new'
end
