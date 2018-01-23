require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.create!(name: "Samuel", email:"s@gmail.com", password: "password")}

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
      expect(user).to have_attributes(name: "Samuel", email:"s@gmail.com")
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
    let(:user_invalid_name) {User.new(name: "", email: "s@gmail.com", password: "password")}
    let(:user_invalid_email) {User.new(name: "samuel", email: "", password: "password")}

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
      #creator of post will automatically have favorited post
      @other_user = User.create!(name: "Other Samuel", email:"others@gmail.com", password: "password")
    end
    it "returns nil if the user has not favorited that post" do
      expect(@other_user.favorite_for(@post)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      favorite = Favorite.create!(user: @other_user, post: @post)
      expect(@other_user.favorite_for(@post)).to eq(favorite)
    end
  end
end
