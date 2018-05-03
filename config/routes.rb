require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api do
    namespace :v2 do
      post 'auth_user' => 'authentication#authenticate_user'
      post 'sign_up' => 'authentication#sign_up'
      get 'home' => 'home#index'
      resources :movies, only: %i[index show]
      resources :news, only: %i[index show]
      resources :comments, only: %i[create destroy]
    end
  end

  get '/', to: 'application#index', format: false
  get '/*path', to: 'application#index', format: false

  # use_doorkeeper
  # devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # root to: 'questions#index'
  #
  # concern :votable do
  #   member do
  #     post :upvote
  #     post :downvote
  #     delete :unvote
  #   end
  # end
  #
  # concern :commentable do
  #   post :comment, on: :member
  # end
  #
  # get 'confirm/:link', to: 'users#confirm', as: 'confirm'
  # post 'send_confirmation', to: 'users#send_confirmation'
  #
  # get 'tags/:tag', to: 'questions#index', as: :tag
  # resources :questions, except: %i[edit], concerns: [:votable, :commentable] do
  #   resources :answers, except: %i[edit new show], concerns: [:votable, :commentable] do
  #     patch 'best', on: :member
  #   end
  #   resource :subscriptions, only: %i[create destroy]
  # end
  #
  # resource :tags, only: [:show]
  #
  # resource :searches, only: [] do
  #   post 'search'
  # end
  #
  # resources :attachments, only: :destroy
  #
  # mount ActionCable.server => "/cable"

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
