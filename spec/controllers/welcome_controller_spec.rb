require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
    describe "GET index" do
        it "renders the index view" do
            get :index  #calls an http request on index
            expect(response).to render_template("index")
        end
    end

    describe "GET about" do
        it "renders the about view" do
          get :about
          expect(response).to render_template("about")
        end
    end 

    describe "GET faq" do #controller serving up the faq view off the back of an http request
        it "renders the faq view" do
            get :faq        # call the faq method (action) in our controller
            expect(response).to render_template("faq")
        end
    end
end
