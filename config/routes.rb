Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions, except: %i[edit] do
    resources :answers, except: %i[edit]
  end
end
