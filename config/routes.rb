Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions, except: %i[edit] do
    post 'upvote', on: :member
    post 'downvote', on: :member
    delete 'unvote', on: :member
    resources :answers, except: %i[edit] do
      patch 'best', on: :member
      post 'upvote', on: :member
      post 'downvote', on: :member
      delete 'unvote', on: :member
    end
  end

  resources :attachments, only: :destroy

  mount ActionCable.server => "/cable"
end
