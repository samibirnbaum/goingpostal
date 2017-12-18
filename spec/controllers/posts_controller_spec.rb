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
      my_post
      get :index
      expect(assigns(:posts)).to eq([my_post]) #assigns to IV on route call, and array with one post in
    end

    it "assigns all the posts from the database to @posts" do
      16.times {Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}
      get :index
      expect(assigns(:posts).size).to eq(16)
    end
    it "changes the first and every fifth title to SPAM" do
      16.times {Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}
      get :index
      expect(assigns(:posts)[0].title).to eq("SPAM")
      expect(assigns(:posts)[5].title).to eq("SPAM")
      expect(assigns(:posts)[10].title).to eq("SPAM")
      expect(assigns(:posts)[15].title).to eq("SPAM")
    end
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
