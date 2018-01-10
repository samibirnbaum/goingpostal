require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) {User.create!(name: "Samuel", email:"s@gmail.com", password: "password")}
  let(:topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:post) {topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user_id: user.id) }
  let(:comment) {Comment.create!(body: "comment body", post: post)} #post references that post object we just created on line above

  describe "attributes" do
    it "has body attribute" do
      expect(comment).to have_attributes(body: "comment body")
    end
  end
end
