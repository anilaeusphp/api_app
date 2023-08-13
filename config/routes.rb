Rails.application.routes.draw do

  scope "api" do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  get 'products/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace "api" do
    resources :products
    resources :categories
  end

  
end
