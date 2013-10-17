MiniRecruiting::Application.routes.draw do
  root :to => 'advertisements#index'
  
  resources :advertisements, only: :show do
    resources :job_applications, only: [:new, :create]
  end
  
  scope "/applicants/:applicant_id", as: "applicant" do
    resources :job_applications, only: [:edit, :update, :show]
  end
  

  devise_for :users, controllers: {sessions: "sessions"}
  devise_for :applicants, :controllers => {:registrations => "applicant_registrations"}
  devise_for :admin
  
  resources :users
  
  namespace :admin do
    resources :users
    resources :advertisements
    resources :job_applications
    root :to => 'users#index'
  end
  get "/guest/apply_for/:advertisement_id/new", to: "guest_apply#new", as: "guest_new"
  post "/guest/apply_for/:advertisement_id/", to: "guest_apply#create", as: "guest_create"


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
