Rails.application.routes.draw do

  namespace :admin do
    resources :taxons do
      get :children, :on => :member
    end

    resources :taxonomies do
      resources :taxons
    end
  end


  root :to => "admin/taxonomies#index"
  
end
