require 'rails_helper'
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do
    let(:topic) { create(:topic) }
    let(:my_user) { create(:user) }
    let(:my_post) { create(:post) } #associations happen in factory, but can write explicitly to be more clear

    context "guest user" do
        describe "POST #create" do
            it "redirects guest to sign in page" do
                post :create, params: {post_id: my_post.id}
                expect(response).to redirect_to(new_session_path)
            end
        end

        describe "DELETE #destroy" do
            it "redirects guest to sign in page" do
                my_favorite = Favorite.create!(user_id: my_user.id, post_id: my_post.id)
                delete :destroy, params: {post_id: my_post.id, id: my_favorite.id}
                expect(response).to redirect_to(new_session_path)
            end
        end
    end

    
    
    
    context "signed-in user" do
        before do
            create_session(my_user)
        end
        describe "POST #create" do
            it "creates a favorite for the current user on that post" do
                expect(current_user.favorite_for(my_post)).to be_falsey
                post :create, params: {post_id: my_post.id}
                expect(current_user.favorite_for(my_post)).to be_truthy
            end

            it "redirects to the post show view" do
                post :create, params: {post_id: my_post.id}
                expect(response).to redirect_to(topic_post_path(my_post.topic.id, my_post.id))
            end
        end

        describe "DELETE #destroy" do
            it "deletes the favorite object from the db for that user and post" do
                my_favorite = Favorite.create!(user_id: my_user.id, post_id: my_post.id)
                expect(current_user.favorite_for(my_post)).to be_truthy
                delete :destroy, params: {post_id: my_post.id, id: my_favorite.id}
                expect(current_user.favorite_for(my_post)).to be_nil
            end

            it "redirects to the post show view" do
                my_favorite = Favorite.create!(user_id: my_user.id, post_id: my_post.id)
                delete :destroy, params: {post_id: my_post.id, id: my_favorite.id}
                expect(response).to redirect_to(topic_post_path(my_post.topic.id, my_post.id))
            end
        end
    end
end

