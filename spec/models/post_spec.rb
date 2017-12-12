require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") } #create is an acitve record method that creates a new object using hash key/values for attributes and saves it straight to the db
  
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end
end
