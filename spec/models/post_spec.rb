require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) {User.create!(name: "Samuel", email:"s@gmail.com", password: "password")}
  let(:topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)} #default public: true
  let(:post) {Post.create!(title: "my post", body: "the body of my post!", topic_id: topic.id, user_id: user.id)} #creating posts based off the topic object

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }

  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_presence_of(:topic)}
  it {is_expected.to validate_presence_of(:user)}

  it {is_expected.to validate_length_of(:title).is_at_least(5)}
  it {is_expected.to validate_length_of(:body).is_at_least(20)}
  
  describe "attributes" do
    it "has title and body attributes and the topic and user associations" do
      expect(post).to have_attributes(title: "my post", body: "the body of my post!", topic_id: topic.id, user_id: user.id)
    end
  end

  describe "post methods for votes" do
    before do
      3.times {Vote.create!(value: 1, user: user, post: post)}
      2.times {Vote.create!(value: -1, user: user, post: post)}
    end

    describe "#up_votes" do
      it "counts the number of up votes for the given post" do
        expect(post.up_votes).to eq(Vote.where(value: 1, post: post).count)
      end
    end

    describe "#down_votes" do
      it "counts the number of down votes for the given post" do
        expect(post.down_votes).to eq(Vote.where(value: -1, post: post).count)
      end
    end

    describe "points" do
      it "returns the sum of all down and up votes" do
        up_votes = Vote.where(value: 1, post: post).count
        down_votes = Vote.where(value: -1, post: post).count
        expect(post.points).to eq(up_votes - down_votes)
      end
    end
  end
end
