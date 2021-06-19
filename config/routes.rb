Rails.application.routes.draw do
  devise_for :companies

  namespace :inventory do
    resources :products
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
