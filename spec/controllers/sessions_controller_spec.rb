require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    let(:my_user) { User.create!(name: "Blochead", email: "blochead@bloc.io", password: "password") }

    describe "GET #new" do
        it "returns http success" do
            get :new
            expect(response).to have_http_status(:success)
        end
    end

    describe "POST #create" do
        it "returns http success" do
            post :create, params: { session: { email: my_user.email } }
            expect(response).to have_http_status(:success)
        end

        #****IF****#
        it "initializes a session" do
            post :create, params: { session: { email: my_user.email, password: my_user.password } }
            expect(session[:user_id]).to eq my_user.id #creation of a session is setting the user id on the session object
        end

        it "redirects to the root view" do
            post :create, params: { session: { email: my_user.email, password: my_user.password } }
            expect(response).to redirect_to(root_path)
        end

        #****ELSE****#
        it "session is not touched due to missing password" do
            post :create, params: { session: { email: my_user.email } }
            expect(session[:user_id]).to be_nil
        end

        it "flashes #error with bad email address" do
            post :create, params: { session: { email: "does not exist" } }
            expect(flash.now[:alert]).to be_present
        end

        it "renders #new with bad email address" do
            post :create, params: { session: { email: "does not exist" } }
            expect(response).to render_template :new
        end
    end

    describe "DELETE #destroy" do
        it "deletes the user's session" do
            delete :destroy, params: { id: my_user.id }
            expect(assigns(:session)).to be_nil #this in essence kills the session
        end
      
        it "flashes #notice" do
            delete :destroy, params: { id: my_user.id }
            expect(flash[:notice]).to be_present
        end

        it "render the #welcome view" do
            delete :destroy, params: { id: my_user.id }
            expect(response).to redirect_to root_path
        end
    end
end
