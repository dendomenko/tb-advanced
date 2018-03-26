require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root to: 'questions#index'

  concern :votable do
    member do
      post :upvote
      post :downvote
      delete :unvote
    end
  end

  concern :commentable do
    post :comment, on: :member
  end

  get 'confirm/:link', to: 'users#confirm', as: 'confirm'
  post 'send_confirmation', to: 'users#send_confirmation'

  get 'tags/:tag', to: 'questions#index', as: :tag
  resources :questions, except: %i[edit], concerns: [:votable, :commentable] do
    resources :answers, except: %i[edit new show], concerns: [:votable, :commentable] do
      patch 'best', on: :member
    end
    resources :subscriptions, only: %i[create destroy]
  end

  resource :searches, only: [] do
    post 'search'
  end

  resources :attachments, only: :destroy

  mount ActionCable.server => "/cable"

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end
      resources :questions, only: %i[index show create] do
        resources :answers, only: %i[index show create]
      end
    end
  end
end
