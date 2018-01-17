require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) {User.create!(name: "Samuel", email:"s@gmail.com", password: "password")}
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
end
