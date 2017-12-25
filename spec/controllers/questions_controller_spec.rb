require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
let(:my_question) {Question.create!(title: "question title", body: "question body", resolved: false)}
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders #index view" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns all the questions to @questions" do
      Question.create!(title: "question title1", body: "question body1", resolved: false)
      Question.create!(title: "question title2", body: "question body2", resolved: false)
      get :index
      expect(assigns(:questions)).to eq(Question.all)
    end
  end

  
  
  
  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: my_question.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {id: my_question.id}
      expect(response).to render_template(:show)
    end

    it "assigns to @question the question with the id used in the url" do
      get :show, params: {id: my_question.id}
      expect(assigns(:question)).to eq(my_question)
    end
  end

  
  
  
  
  
  
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new question object (to be created in the new view) to @question" do
      get :new
      expect(assigns(:question)).to be_an_instance_of(Question)
    end
  end

  
  
  
  
  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end












  describe "POST #create" do
    it "assigns to @question the url parameters it receives" do
      post :create, params: {question: {title: "create1title", body:"create1body", resolved: false}}
      expect(assigns(:question).title).to eq("create1title")
      expect(assigns(:question).body).to eq("create1body")
      expect(assigns(:question).resolved).to eq(false) 
    end

    it "increases rows in the db by 1" do
      expect{ 
        post :create, params: {question: {title: "create1title", body:"create1body", resolved: false}}
      }.to change{Question.count}.by(1)
    end

    it "redirects to #show view, using question id just created" do
      post :create, params: {question: {title: "create1title", body:"create1body", resolved: false}}
      expect(response).to redirect_to(question_path(Question.last.id))
    end
  end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #delete" do
  #   it "returns http success" do
  #     get :delete
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
