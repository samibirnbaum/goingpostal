require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:my_user) {User.create!(name: "Samuel", email:"s@gmail.com", password: "password")}
  let(:my_topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:my_post) {Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, topic: my_topic, user: my_user)}

  
  
  describe "GET #show" do
    it "returns http success" do
      get :show, params: {topic_id: my_topic.id, id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {topic_id: my_topic.id, id: my_post.id}
      expect(response).to render_template(:show)
    end

    it "the show action assigns the post we are viewing to @post" do
      get :show, params: {topic_id: my_topic.id, id: my_post.id}
      expect(assigns(:post)).to eq(my_post)
    end
  end

  
  
  
  
  
  
  describe "GET #new" do
    it "returns http success" do  #check that some sort of response happens from the sever
      get :new, params: {topic_id: my_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do   #that response should be the new view
      get :new, params: {topic_id: my_topic.id} #when the new method is called from a url
      expect(response).to render_template(:new) #it renders the new view in the application view
    end

    it "instantiates @post" do
      get :new, params: {topic_id: my_topic.id}
      expect(assigns(:post)).not_to be_nil  #the method initializes this variable which holds the post object
    end
  end



  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {topic_id: my_topic.id, id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the edit view" do
      get :edit, params: {topic_id: my_topic.id, id: my_post.id}
      expect(response).to render_template(:edit)
    end

    it "assigns correct post for editing to the post variable" do
      get :edit, params: {topic_id: my_topic.id, id: my_post.id}
      expect(assigns(:post)).to eq(Post.find(my_post.id))
    end
  end

  
  
  describe "PUT #update" do
    it "updates @post variable with new attributes" do
      put :update, params: {topic_id: my_topic.id, id: my_post.id, post: {title: "updated title", body: "updated body"}}
      expect(assigns(:post).id).to eq(my_post.id)
      expect(assigns(:post).title).to eq("updated title")
      expect(assigns(:post).body).to eq("updated body")
    end

    it "shows the updated post in the #show view" do
      put :update, params: {topic_id: my_topic.id, id: my_post.id, post: {title: "updated title", body: "updated body"}}
      expect(response).to redirect_to(topic_post_path(my_topic.id, my_post.id))
    end
  end



#####NOTE: IN RSPEC LOST OF PASSING OF VAR'S AND METHODS INTO RSPEC METHODS - USING SYMBOLS TO DO THIS####

  describe "POST create" do
    it "increases the number of posts in the db by 1" do
      #post http method - calls create action - url has parameters
      expect{ post :create, params: {topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)      
    end

    it "assigns the new post to @post" do #this method has some form of post variable that we want to hold the post we save to the db
      post :create, params: {topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
      post :create, params: {topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(response).to redirect_to topic_post_path(my_topic.id, Post.last.id)
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the selected post from the database" do
      delete :destroy, params: {topic_id: my_topic.id, id: my_post.id}
      expect(Post.where({id: my_post.id}).size).to eq(0)
    end

    it "redirects us back to posts home page (index)" do
      delete :destroy, params: {topic_id: my_topic.id, id: my_post.id}
      expect(response).to redirect_to(topic_path(my_topic.id))
    end
  end

end
