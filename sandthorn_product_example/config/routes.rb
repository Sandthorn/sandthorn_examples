SandthornProductExample::Application.routes.draw do
  root "welcome#index"

  #actice record product routes
  resources :products

  #sandthorn product routes
  match "/sandthorn/products/index" => "sandthorn_products#index", :via => "get"
  match "/sandthorn/products/new" => "sandthorn_products#new", :via => "get"
  match "/sandthorn/products/" => "sandthorn_products#new", :via => "get"
  match "/sandthorn/product/:id" => "sandthorn_products#show", :via => "get"
  match "/sandthorn/product/:id/update" => "sandthorn_products#update", :via => "post"
  match "/sandthorn/product/:id/edit" => "sandthorn_products#edit", :via => "get"
  match "/sandthorn/products" => "sandthorn_products#create", :via => "post"
  match "/sandthorn/products/create" => "sandthorn_products#create", :via => "post"
  match "/sandthorn/product/:id/destroy" => "sandthorn_products#destroy", :via => "post"



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
