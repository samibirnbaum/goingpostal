require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  #I have access to the post model to create a new post object and save to the db
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do #if we call the post/index url - the controller should automatically assign all posts to @posts IV
      get :index
      expect(assigns(:posts)).to eq([my_post]) #assigns to IV on route call, and array with one post in
    end
  end

  
  
  
  
  
  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {id: my_post.id}
      expect(response).to render_template(:show)
    end

    it "the show action assigns the post we are viewing to @post" do
      get :show, params: {id: my_post.id}
      expect(assigns(:post)).to eq(my_post)
    end
  end

  
  
  
  
  
  
  describe "GET #new" do
    it "returns http success" do  #check that some sort of response happens from the sever
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do   #that response should be the new view
      get :new #when the new method is called from a url
      expect(response).to render_template(:new) #it renders the new view in the application view
    end

    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil  #the method initializes this variable which holds the post object
    end
  end



  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the edit view" do
      get :edit, params: {id: my_post.id}
      expect(response).to render_template(:edit)
    end

    it "assigns correct post for editing to the post variable" do
      get :edit, params: {id: my_post.id}
      expect(assigns(:post)).to eq(Post.find(my_post.id))
    end
  end

  describe "PUT #update" do
    it "updates @post variable with new attributes" do
      put :update, params: {id: my_post.id, post: {title: "updated title", body: "updated body"}}
      expect(assigns(:post).id).to eq(my_post.id)
      expect(assigns(:post).title).to eq("updated title")
      expect(assigns(:post).body).to eq("updated body")
    end

    it "shows the updated post in the #show view" do
      put :update, params: {id: my_post.id, post: {title: "updated title", body: "updated body"}}
      expect(response).to redirect_to(post_path(my_post.id))
    end
  end



#####NOTE: IN RSPEC LOST OF PASSING OF VAR'S AND METHODS INTO RSPEC METHODS - USING SYMBOLS TO DO THIS####

  describe "POST create" do
    it "increases the number of posts in the db by 1" do
      #post http method - calls create action - url has parameters
      expect{ post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)      
    end

    it "assigns the new post to @post" do #this method has some form of post variable that we want to hold the post we save to the db
      post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
      post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(response).to redirect_to Post.last
    end
  end

end
