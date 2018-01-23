require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) {User.create!(name: "Samuel", email:"s@gmail.com", password: "password")}
  let(:other_user) {User.create!(name: "Other Samuel", email:"others@gmail.com", password: "password")}
  let(:topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:post) {topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user_id: user.id) }
  let(:comment) {Comment.create!(body: "comment body", post: post, user: user)} #post references that post object we just created on line above

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }
  
  describe "attributes" do
    it "has body attribute" do
      expect(comment).to have_attributes(body: "comment body")
    end
  end

  describe "after_create" do
    #two things happening here
    #1. a post is created by a user THEY AUTOMATICALLY FAVORITE THE POST due to code in Post model
    #2. to test functionality must create other user who FAVORITES THE POST VOLUNTARILY
    #However, on a new comment 2 emails will be sent, one to AUTOMATIC FAVOURITER and one to VOLUNTARY FAVOURITER 
    before do
      @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
    end
    
    it "sends an email to users who have favorited the post" do
      favorite = Favorite.create!(user: other_user, post: post)
      expect { @another_comment.send(:send_favorite_emails) }.to change { ActionMailer::Base.deliveries.count }.by(2)
      @another_comment.save! #user gets an email and other_user gets an email
    end

    it "does not send email to users who have not favortied the post" do
      expect { @another_comment.send(:send_favorite_emails) }.to change { ActionMailer::Base.deliveries.count }.by(1)
      @another_comment.save! #user who created post will get an email as they are automatic favoriter
    end
  end
end
