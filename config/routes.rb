Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions, except: %i[edit] do
    post 'vote', on: :member
    delete 'unvote', on: :member
    resources :answers, except: %i[edit] do
      patch 'best', on: :member
      post 'vote', on: :member
      delete 'unvote', on: :member
    end
  end

  resources :attachments, only: :destroy
end
