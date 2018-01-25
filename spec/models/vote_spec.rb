require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:vote) { create(:vote, post: post, user: user)}

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
