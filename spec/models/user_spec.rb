require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) } #from factory

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { is_expected.to have_secure_password }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }

  describe "attributes" do
    it "has the attrs @name @email @password_digest" do
      expect(user).to have_attributes(name: user.name, email: user.email)
      expect(user.attributes).to include("password_digest") #cant check for password because it has become a hashed P_D
    end

    it "has attribute @role" do
      expect(user).to respond_to(:role)
    end

    it "has concealed enum method admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "has concealed enum method member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "role" do 
    it "is member by default" do
      expect(user.role).to eq("member")
    end

    context "member user" do
      it "returns true when #member? called" do
        expect(user.member?).to be_truthy
      end

      it "returns false when #admin? called" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do

      before do
        user.admin! #sets role attribute to = "admin" - one of ?/! methods provided by an anum attribute
      end

      it "returns true on #admin?" do
        expect(user.admin?).to be_truthy
      end

      it "returns false on #member?" do
        expect(user.member?).to be_falsey
      end
    end
  end

  #true negative
  describe "invalid user" do
    let(:user_invalid_name) {build(:user, name: "")}
    let(:user_invalid_email) {build(:user, email: "")}

    it "should be an invalid user due to blank name" do
      expect(user_invalid_name).to_not be_valid #calls valid? on the object
    end

    it "should be an invalid user due to blank email" do
      expect(user_invalid_email).to_not be_valid
    end
  end

  describe "#favorite_for(post)" do
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: true)
      @post = Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user, topic: topic)
    end
    it "returns nil if the user has not favorited that post" do
      expect(user.favorite_for(@post)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      favorite = Favorite.create!(user: user, post: @post)
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end

    describe ".avatar_url(size)" do # . = class method User.avatar_url
        let(:known_user) { create(:user, email: "blochead@bloc.io") } #overrides email in factory (need recognised known email for this test)
        
        it "returns the proper gravatar for an email registered with gravatar" do
            expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
            expect(known_user.avatar_url(48)).to eq(expected_gravatar)
        end 
    end
end
