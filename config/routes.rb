Rails.application.routes.draw do
  devise_for :users
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

  resources :questions, except: %i[edit], concerns: [:votable, :commentable] do
    resources :answers, except: %i[edit], concerns: [:votable, :commentable] do
      patch 'best', on: :member
    end
  end

  resources :attachments, only: :destroy

  mount ActionCable.server => "/cable"
end
