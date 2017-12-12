require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
  let(:comment) {Comment.create!(body: "comment body", post: post)} #for some reason this references the post we just created as the post_id

  describe "attributes" do
    it "has body attribute" do
      expect(comment).to have_attributes(body: "comment body")
    end
  end
end
