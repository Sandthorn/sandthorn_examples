SandthornProductExample::Application.routes.draw do
  get "products/index"
  get "products/new"
  get "products/update"
  get "products/destroy"
  get "products/create"
  get "products/show"
  root "welcome#index"

  #actice record product routes
  resources :products

  namespace :sandthorn do
    get "log"
    resources :products do
      post :change_name
      post :change_price
      post :in_stock
      post :out_of_stock
      post :discontinue
      post :put_on_sale
      post :remove_from_sale
    end
  end

  match "/sandthorn/log" => "sandthorn_products_tasked_based#get_log", :via => "get"
end
