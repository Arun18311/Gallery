Rails.application.routes.draw do
  devise_for :users
  get "albums/myalbum"
  get "albums/draft"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "albums#index"
  resources :albums do
    member do 
      delete :delete_image_attachment
    end
  end
  resource :users
end
