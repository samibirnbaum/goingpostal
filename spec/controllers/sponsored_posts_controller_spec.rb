require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
    let(:my_topic) {Topic.create!(name: "i am a topic", description:"i am a description")}
    let(:my_spost) {SponsoredPost.create!(title: "spost title", body: "spost descrip", price: 3000000, topic_id: my_topic.id)}
    
    describe "GET #new" do
        it "assigns @spost a new spost object to be populated by user in view" do
            get :new, params: {topic_id: my_topic.id}
            expect(assigns(:spost)).to be_an_instance_of(SponsoredPost)
        end

        it "assigns @topic, the topic in question that we will use in our form_for to create the associated post" do
            get :new, params: {topic_id: my_topic.id}
            expect(assigns(:topic)).to eq(my_topic)
        end

        it "returns http success" do  #check that some sort of response happens from the server
            get :new, params: {topic_id: my_topic.id}
            expect(response).to have_http_status(:success)
        end
      
        it "renders the #new view" do   #that response should be the new view
            get :new, params: {topic_id: my_topic.id} #when the new method is called from a url
            expect(response).to render_template(:new) #it renders the new view in the application view
        end
    end

    describe "POST #create" do
        it "assigns to @spost the correct values from the POST request" do
            post :create, params: {sponsored_post: {title: "SP title", body: "SP body", price: 3000}, topic_id: my_topic.id}
            expect(assigns(:spost).title).to eq("SP title")
            expect(assigns(:spost).body).to eq("SP body")
            expect(assigns(:spost).price).to eq(3000)
            expect(assigns(:spost).topic_id).to eq(my_topic.id)
        end

        it "saves to the databse increasing Sponsored Post table rows by 1" do
            expect{post :create, params: {sponsored_post: {title: "SP title", body: "SP body", price: 3000}, topic_id: my_topic.id}}.to change{SponsoredPost.all.size}.by(1)
        end

        it "redirects user when successful to spost show view" do
            post :create, params: {sponsored_post: {title: "SP title", body: "SP body", price: 3000}, topic_id: my_topic.id}
            expect(response).to redirect_to(topic_sponsored_post_path(my_topic.id, SponsoredPost.last.id))
        end
    end
end
