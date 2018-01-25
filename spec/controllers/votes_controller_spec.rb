require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
    let(:topic) {create(:topic)}
    
    let(:my_user) {create(:user)}
    let(:my_vote) {Vote.create!(value: 1)}

    let(:other_user) {create(:user)}
    let(:other_user_post) {create(:post, user: other_user, topic: topic)}
    

    context "guest" do
        describe "POST #up_vote" do
            it "will redirect the guest to sign in" do
                post :up_vote, params: {post_id: other_user_post.id}
                expect(response).to redirect_to(new_session_path)
            end
        end

        describe "POST down_vote" do
            it "redirects the user to the sign in view" do
                delete :down_vote, params: { post_id: other_user_post.id }
                expect(response).to redirect_to(new_session_path)
            end
        end
    end

    
    
    
    
    context "signed in" do
        before do
            create_session(my_user)
            request.env["HTTP_REFERER"] = topic_post_path(topic, other_user_post) #need this because in method using redirect_back which relies on this object attribute being set
        end
        
        describe "POST #up_vote" do
            it "the users first vote increases number of votes by 1" do
                votes = other_user_post.votes.count
                post :up_vote, params: {post_id: other_user_post.id}
                expect(other_user_post.votes.count).to eq(votes + 1)
            end

            it "the users second vote does not increase number of votes" do
                post :up_vote, params: {post_id: other_user_post.id}
                votes = other_user_post.votes.count
                post :up_vote, params: {post_id: other_user_post.id}
                expect(other_user_post.votes.count).to eq(votes)
            end

            it "because its an up vote, increases points by 1" do
                points = other_user_post.points
                post :up_vote, params: {post_id: other_user_post.id}
                expect(other_user_post.points).to eq(points + 1)
            end

            it "redirects back to previous page - posts show" do
                request.env["HTTP_REFERER"] = topic_post_path(topic, other_user_post)
                post :up_vote, params: {post_id: other_user_post.id}
                expect(response).to redirect_to(topic_post_path(topic, other_user_post))
            end

            it "redirects back to previous page - topic show" do
                request.env["HTTP_REFERER"] = topic_path(topic)
                post :up_vote, params: {post_id: other_user_post.id}
                expect(response).to redirect_to(topic_path(topic))
            end
        end

        describe "POST #down_vote" do
            it "the users first vote increases number of votes by 1" do
                votes = other_user_post.votes.count
                post :down_vote, params: {post_id: other_user_post.id}
                expect(other_user_post.votes.count).to eq(votes + 1)
            end

            it "the users second vote does not increase number of votes" do
                post :down_vote, params: {post_id: other_user_post.id}
                votes = other_user_post.votes.count
                post :down_vote, params: {post_id: other_user_post.id}
                expect(other_user_post.votes.count).to eq(votes)
            end

            it "because its a down vote, decreases points by 1" do
                points = other_user_post.points
                post :down_vote, params: {post_id: other_user_post.id}
                expect(other_user_post.points).to eq(points - 1)
            end

            it "redirects back to previous page - posts show" do
                request.env["HTTP_REFERER"] = topic_post_path(topic, other_user_post)
                post :down_vote, params: {post_id: other_user_post.id}
                expect(response).to redirect_to(topic_post_path(topic, other_user_post))
            end

            it "redirects back to previous page - topic show" do
                request.env["HTTP_REFERER"] = topic_path(topic)
                post :down_vote, params: {post_id: other_user_post.id}
                expect(response).to redirect_to(topic_path(topic))
            end
        end
    end
end
