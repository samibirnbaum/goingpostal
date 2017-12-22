Rails.application.routes.draw do
  
  resources :advertisements  

  resources :posts #creates routes from the url to the posts controller

  get 'about' => 'welcome#about' #url of about should route to about method in welcome controller

  root 'welcome#index' #using root url go to index method in welcome controller

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
