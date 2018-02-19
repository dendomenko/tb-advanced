Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions, except: %i[edit update destroy] do
    resources :answers, except: %i[edit update destroy]
  end
end
