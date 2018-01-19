Rails.application.routes.draw do
  
  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do #nests comments without creating any routes for posts, because these were created above
    resources :comments, only: [:create, :destroy]
    post "/up-vote" => "votes#up_vote", as: :up_vote
    post "/down-vote" => "votes#down_vote", as: :down_vote
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]
  
  get 'about' => 'welcome#about' #url of about should route to about method in welcome controller
  
  root 'welcome#index' #using root url go to index method in welcome controller

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
