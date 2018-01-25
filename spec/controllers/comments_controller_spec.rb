require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
    let(:topic) {create(:topic)}
    let(:user) {create(:user)}
    let(:other_user) {create(:user)}
    let(:my_post) {create(:post, user: user)}
    let(:comment) {Comment.create!(body: RandomData.random_paragraph, post: my_post, user: user)}
    

    context "guest" do
        describe "POST #create" do
            it "redirects guest to sign in page" do
                post :create, params: {post_id: my_post.id, comment: {body: RandomData.random_paragraph}}
                expect(response).to redirect_to(new_session_path)
            end
        end

        describe "DELETE #destroy" do
            it "redirects guest to sign in page" do
                delete :destroy, params: {post_id: my_post.id, id: comment.id}
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    
    
    
    
    
    
    
    context "member on own comment" do
        before do
            create_session(user)
        end
        describe "POST #create" do
            it "assigns correct values to @comment" do
                post :create, params: {post_id: my_post.id, comment: {body: "aaaaaaaaaaaaaaaaaaaaaaaaaaaa"}} #not taking in user who is associated with comment in the params (shallow params) will still add in create action before comment saved to database
                expect(assigns(:comment).post_id).to eq(my_post.id)
                expect(assigns(:comment).body).to eq("aaaaaaaaaaaaaaaaaaaaaaaaaaaa")
            end

            it "saves the comment increaing db by 1" do
                expect{ post :create, params: {post_id: my_post.id, comment: {body: RandomData.random_sentence}}}.to change(Comment,:count).by(1)
            end

            it "redirects user to show post" do
                post :create, params: {post_id: my_post.id, comment: {body: RandomData.random_paragraph}}
                expect(response).to redirect_to(topic_post_path(my_post.topic.id, my_post.id))
            end
        end

        describe "DELETE #destroy" do
            it "deletes the comment from the db" do
                delete :destroy, params: {post_id: my_post.id, id: comment.id}
                count = Comment.where({id: comment.id}).count
                expect(count).to eq 0
            end

            it "redirects user" do
                delete :destroy, params: {post_id: my_post.id, id: comment.id}
                expect(response).to redirect_to(topic_post_path(my_post.topic.id, my_post.id))
            end
        end
    end
    
    
    
    
    
    
    
    
    context "member on someone elses comment" do
        before do
            create_session(other_user)
        end
        
        describe "POST create" do
            it "increases the number of comments by 1" do
              expect{ post :create, params: {post_id: my_post.id, comment: {body: RandomData.random_sentence}}}.to change(Comment,:count).by(1)
            end
      
            it "redirects to the post show view" do
              post :create, params: {post_id: my_post.id, comment: {body: RandomData.random_sentence}}
              expect(response).to redirect_to(topic_post_path(my_post.topic.id, my_post.id))
            end
          end

        describe "DELETE #destroy" do
            it "redirects member to same page" do
                delete :destroy, params: {post_id: my_post.id, id: comment.id}
                expect(response).to redirect_to(topic_post_path(my_post.topic.id, my_post.id))
            end
        end
    end
    
    
    
    
    
    
    context "admin" do
        before do
            other_user.admin!
            create_session(other_user)
        end
        describe "POST #create" do
            it "assigns correct values to @comment" do
                post :create, params: {post_id: my_post.id, comment: {body: "aaaaaaaaaaaaaaaaaaaaaaaaaaaa"}} #not taking in user who is associated with comment in the params (shallow params) will still add in create action before comment saved to database
                expect(assigns(:comment).post_id).to eq(my_post.id)
                expect(assigns(:comment).body).to eq("aaaaaaaaaaaaaaaaaaaaaaaaaaaa")
            end

            it "saves the comment increaing db by 1" do
                expect{ post :create, params: {post_id: my_post.id, comment: {body: RandomData.random_sentence}} }.to change(Comment,:count).by(1)
            end

            it "redirects user to show post" do
                post :create, params: {post_id: my_post.id, comment: {body: RandomData.random_paragraph}}
                expect(response).to redirect_to(topic_post_path(my_post.topic.id, my_post.id))
            end
        end

        describe "DELETE #destroy" do
            it "deletes the comment from the db" do
                delete :destroy, params: {post_id: my_post.id, id: comment.id}
                count = Comment.where({id: comment.id}).count
                expect(count).to eq 0
            end

            it "redirects user" do
                delete :destroy, params: {post_id: my_post.id, id: comment.id}
                expect(response).to redirect_to(topic_post_path(my_post.topic.id, my_post.id))
            end
        end
    end
end
