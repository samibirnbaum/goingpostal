require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: true)}
  let(:user) {User.create!(name: RandomData.random_name, email: "s@gmail.com", password: "password", role: "member")}
  let(:post) {Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, topic: topic, user: user)}
  let(:vote) {Vote.create!(value: 1, post: post, user: user)}

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:value) }

  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) } #value can only be -1 or 1

  describe "update_post (after_save) callback" do
    it "after_save on vote object triggers update_post" do
      expect(vote).to receive(:update_post).at_least(:once)
      vote.save!
    end

    it "update_post then triggers update_rank on post associated with vote" do
      expect(post).to receive(:update_rank).at_least(:once)
      vote.save!
    end
  end
end
