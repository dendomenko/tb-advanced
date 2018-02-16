Rails.application.routes.draw do
  resources :questions, except: %i[edit update destroy] do
    resources :answers, except: %i[edit update destroy]
  end
end
