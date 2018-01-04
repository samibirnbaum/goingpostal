Rails.application.routes.draw do
  
  resources :topics do
    resources :posts, except: [:index]
  end

  resources :users, only: [:new, :create]
  
  get 'about' => 'welcome#about' #url of about should route to about method in welcome controller

  root 'welcome#index' #using root url go to index method in welcome controller

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
