require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:description) {RandomData.random_paragraph}
  let(:topic) {Topic.create!(name: name, description: description)} #default public: true


  let(:title) {RandomData.random_sentence}
  let(:body) {RandomData.random_paragraph}
  let(:post) {topic.posts.create!(title: title, body: body)} #creating posts based off the topic object

  it { is_expected.to belong_to(:topic) }
  
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: title, body: body)
    end
  end
end
