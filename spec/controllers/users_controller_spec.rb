require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let(:new_user_attributes) do
        {
            name: "BlocHead",
            email: "blochead@bloc.io",
            password: "blochead",
            password_confirmation: "blochead"
        }
      end

    describe "GET #new" do
        it "assigns to @user a new user object" do
            get :new
            expect(assigns(:user)).to be_an_instance_of(User)
        end

        it "returns http success" do
            get :new
            expect(response).to have_http_status(:success)
        end

        it "renders the new template" do
            get :new
            expect(response).to render_template(:new)
        end
    end
    
    describe "POST #create" do
        it "assigns the values in form to @user" do
            post :create, params: { user: new_user_attributes }
            expect(assigns(:user).name).to eq(new_user_attributes[:name])
            expect(assigns(:user).email).to eq(new_user_attributes[:email])
            expect(assigns(:user).password).to eq(new_user_attributes[:password])
            expect(assigns(:user).password_confirmation).to eq(new_user_attributes[:password_confirmation])
        end

        it "increases the size of database for users by 1" do
            expect{post :create, params: { user: new_user_attributes }}.to change{User.all.size}.by(1)
        end

        it "redirects user - http redirect" do
            post :create, params: { user: new_user_attributes }
            expect(response).to have_http_status(:redirect)
        end
    end
end
