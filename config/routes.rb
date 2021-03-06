Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  get 'confirm/:link', to: 'users#confirm', as: 'confirm'
  post 'send_confirmation', to: 'users#send_confirmation'

  resource :searches, only: [] do
    post 'search'
  end

  resources :questions do
    post 'vote', on: :member
    delete 'unvote', on: :member
    post :comment, on: :member

    resources :subscriptions, only: %i[create destroy]

    resources :answers do
      patch 'best', on: :member
      post 'vote', on: :member
      delete 'unvote', on: :member
      post :comment, on: :member
    end
  end
  resources :attachments, only: [:destroy]

  root 'questions#index'

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
        get :all
      end
      resources :questions do
        resources :answers, only: %i[index show create]
      end
    end
  end

  mount ActionCable.server => '/cable'
end
