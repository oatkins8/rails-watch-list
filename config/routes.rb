Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "lists#index"

  resources :lists, only: [ :show, :new, :create] do
    resources :bookmarks, only: [:new, :create]
  end
  resources :bookmarks, only: [:destroy]
end

# resources :restaurants do
#   resources :reviews, only: [:new, :create] # new and create are linked so we can do both at the same time
# end
