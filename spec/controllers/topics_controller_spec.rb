require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe TopicsController, type: :controller do

    let(:my_topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}

    
    
    
    context "guest" do
        describe "GET #index" do
            it "gives us an http response success" do
                get :index
                expect(response).to have_http_status(:success)
            end

            it "renders the #index view" do
                get :index
                expect(response).to render_template(:index)
            end
            
            it "assigns all the topics to @topics" do
                get :index
                expect(assigns(:topics)).to eq([my_topic]) #@topics will hold array so will only be eq an array which holds my_topic
            end
        end

        describe "GET #show" do
            it "assigns to @topic the topic object whose ID is called in the url" do
                get :show, params: {id: my_topic.id}
                expect(assigns(:topic)).to eq(my_topic)
            end
    
            it "response is an http success" do
                get :show, params: {id: my_topic.id}
                expect(response).to have_http_status(:success)
            end
    
            it "renders specifically the #show view" do
                get :show, params: {id: my_topic.id}
                expect(response).to render_template(:show)
            end
        end

        describe "GET #new" do
            it "returns http redirect" do
                get :new
                expect(response).to redirect_to(new_session_path)
            end
        end
        
        describe "POST create" do
            it "returns http redirect" do
                post :create, params: { topic: { name: RandomData.random_sentence, description: RandomData.random_paragraph } }
                expect(response).to redirect_to(new_session_path)
            end
        end
      
        describe "GET edit" do
            it "returns http redirect" do
                get :edit, params: { id: my_topic.id }
                expect(response).to redirect_to(new_session_path)
            end
        end
      
        describe "PUT update" do
            it "returns http redirect" do
                new_name = RandomData.random_sentence
                new_description = RandomData.random_paragraph
      
                put :update, params: { id: my_topic.id, topic: { name: new_name, description: new_description  } }
                expect(response).to redirect_to(new_session_path)
            end
        end
      
        describe "DELETE destroy" do
            it "returns http redirect" do
                delete :destroy, params: { id: my_topic.id }
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    
    
    
    
    
    
    
    
    
    context "member" do
        before do
            user = User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld", role: :member) #we create a user - sign up
            create_session(user) #sign that user in 
        end
        
        describe "GET #index" do
            it "gives us an http response success" do
                get :index
                expect(response).to have_http_status(:success)
            end

            it "renders the #index view" do
                get :index
                expect(response).to render_template(:index)
            end
            
            it "assigns all the topics to @topics" do
                get :index
                expect(assigns(:topics)).to eq([my_topic]) #@topics will hold array so will only be eq an array which holds my_topic
            end
        end

        describe "GET #show" do
            it "assigns to @topic the topic object whose ID is called in the url" do
                get :show, params: {id: my_topic.id}
                expect(assigns(:topic)).to eq(my_topic)
            end
    
            it "response is an http success" do
                get :show, params: {id: my_topic.id}
                expect(response).to have_http_status(:success)
            end
    
            it "renders specifically the #show view" do
                get :show, params: {id: my_topic.id}
                expect(response).to render_template(:show)
            end
        end

        describe "GET new" do
            it "returns http redirect" do
                get :new
                expect(response).to redirect_to(topics_path)
            end
        end
      
        describe "POST create" do
            it "returns http redirect" do
                post :create, params: { topic: { name: RandomData.random_sentence, description: RandomData.random_paragraph } }
                expect(response).to redirect_to(topics_path)
            end
        end
      
        describe "GET edit" do
            it "returns http redirect" do
                get :edit, params: { id: my_topic.id }
                expect(response).to redirect_to(topics_path)
            end
        end

        describe "PUT update" do
            it "returns http redirect" do
                new_name = RandomData.random_sentence
                new_description = RandomData.random_paragraph
      
                put :update, params: { id: my_topic.id, topic: { name: new_name, description: new_description } }
                expect(response).to redirect_to(topics_path)
            end
        end
      
        describe "DELETE destroy" do
            it "returns http redirect" do
                delete :destroy, params: { id: my_topic.id }
                expect(response).to redirect_to(topics_path)
            end
        end
    end

    
    
    
    
    
    
    
    
    
    
    context "admin" do
        before do
            user = User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld", role: :admin)
            create_session(user)
        end
        
        describe "GET #index" do
            it "gives us an http response success" do
                get :index
                expect(response).to have_http_status(:success)
            end

            it "renders the #index view" do
                get :index
                expect(response).to render_template(:index)
            end
            
            it "assigns all the topics to @topics" do
                get :index
                expect(assigns(:topics)).to eq([my_topic]) #@topics will hold array so will only be eq an array which holds my_topic
            end
        end

        describe "GET #show" do
            it "assigns to @topic the topic object whose ID is called in the url" do
                get :show, params: {id: my_topic.id}
                expect(assigns(:topic)).to eq(my_topic)
            end
    
            it "response is an http success" do
                get :show, params: {id: my_topic.id}
                expect(response).to have_http_status(:success)
            end
    
            it "renders specifically the #show view" do
                get :show, params: {id: my_topic.id}
                expect(response).to render_template(:show)
            end
        end

        describe "GET #new" do
            it "assigns to @topic a brand new topic object for populating in the view" do
                get :new
                expect(assigns(:topic)).to be_an_instance_of(Topic)
            end
        
            it "response is an http success" do
                get :new
                expect(response).to have_http_status(:success)
            end
        
            it "renders specifically the #show view" do
                get :new
                expect(response).to render_template(:new)
            end
        end
        
        describe "POST #create" do
            it "assign to new object @topic the values received in params" do
                post :create, params: {topic: {name: "new topic", description: "new description", public: false}}
                expect(assigns(:topic).name).to eq("new topic")
                expect(assigns(:topic).description).to eq("new description")
                expect(assigns(:topic).public).to eq(false)
            end
    
            it "successfully saves that new topic object to the databse - does number of topics in db increase?" do
                expect{post :create, params: {topic: {name: "new topic", description: "new description", public: false}}}.to change{Topic.count}.by(1)
            end
    
            it "redirects to the show view, to show newly created topic" do
                post :create, params: {topic: {name: "new topic", description: "new description", public: false}}
                expect(response).to redirect_to(topic_path(Topic.last.id))
            end
        end
    
        describe "GET #edit" do
            it "assigns to @topic the topic object whose ID is in the url" do
                get :edit, params: {id: my_topic.id}
                expect(assigns(:topic).name).to eq(my_topic.name)
                expect(assigns(:topic).description).to eq(my_topic.description)
                expect(assigns(:topic).public).to eq(my_topic.public)
            end
    
            it "returns an http status success" do
                get :edit, params: {id: my_topic.id}
                expect(response).to have_http_status(:success)
            end
    
            it "specifically respons with the #edit view" do
                get :edit, params: {id: my_topic.id}
                expect(response).to render_template(:edit)
            end
        end
    
        describe "PUT #update" do
            it "assigns to @topic the topic with url ID to be updated" do
                put :update, params: {id: my_topic.id, topic: {name: "updated name", description: "updated desc", public: false}}
                expect(assigns(:topic).id).to eq(my_topic.id)
                expect(assigns(:topic).name).to eq("updated name")
                expect(assigns(:topic).description).to eq("updated desc")
                expect(assigns(:topic).public).to eq(false)
            end
    
            it "shows the newly updated topic in the #show view" do
                put :update, params: {id: my_topic.id, topic: {name: "updated name", description: "updated desc", public: false}}
                expect(response).to redirect_to(topic_path(my_topic.id))
            end
        end
    
        describe "DELETE #destroy" do
            it "deletes the topic object based on the id received in the url" do
                delete :destroy, params: {id: my_topic.id}
                expect(Topic.where(id: my_topic.id)).to eq([])
            end
            
            it "redirects user back to the home page for topics" do
                delete :destroy, params: {id: my_topic.id}
                expect(response).to redirect_to(topics_path)
            end
        end
    end
end
