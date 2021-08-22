Rails.application.routes.draw do
  resources :users do
  	 member do
  	  get 'orders'
  	end
  end
  resources :products
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  resources :carts, only: [:show], param: :cart_id
  resources :carts, only: [:create] do
  	collection do
  	  post :cart_checkout
  	end
  	resources :cart_items,  only: %i[create update destroy], param: :product_id
  end
match '*path' => 'errors#render_not_found', via: :all   	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
