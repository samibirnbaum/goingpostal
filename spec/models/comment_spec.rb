require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) {create(:user)}
  let(:topic) {create(:topic)}
  let(:post) {create(:post) } #automatically associated with user and topic in the post factory
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
    before do
      @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
    end
    
    it "sends an email to users who have favorited the post" do
      favorite = Favorite.create!(user: user, post: post)
      expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))
      @another_comment.save!
    end

    it "does not send email to users who have not favortied the post" do
      expect(FavoriteMailer).not_to receive(:new_comment)
      @another_comment.save!
    end
  end
end
