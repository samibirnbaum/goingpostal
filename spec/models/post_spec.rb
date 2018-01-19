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

    describe "#update_rank" do
      it "calculates the correct rank" do
        post.update_rank #calls the method
        expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
      end

      it "updates the rank when up vote is created" do
        old_rank = post.rank
        Vote.create!(value: 1, user: user, post: post)
        expect(post.rank).to eq(old_rank + 1)
      end

      it "updates the rank when downvote is created" do
        old_rank = post.rank
        Vote.create!(value: -1, user: user, post: post)
        expect(post.rank).to eq(old_rank - 1)
      end
    end

    describe "after_create #create_vote" do
      let(:new_post) {Post.create!(title: "my post", body: "the body of my post!", topic_id: topic.id, user_id: user.id)}
      it "creates a vote on the post user just made" do
        expect(new_post.votes.first.value).to eq(1)
        expect(new_post.votes.first.post).to eq(new_post)
        expect(new_post.votes.first.user).to eq(user)
      end
      
      it "updates the rank" do
        expect(new_post.rank).to be
      end
    end
  end
end
