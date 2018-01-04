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

  describe "attributes" do
    it "has the attrs @name @email @password_digest" do
      expect(user).to have_attributes(name: "Samuel", email:"s@gmail.com")
      expect(user.attributes).to include("password_digest") #cant check for password because it has become a hashed P_D
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

  describe "before_save formatting of names to capital first letters" do
    it "should capitalize users first and last name" do
      user = User.create!(name: "samuel birnbaum", email:"s@gmail.com", password: "password")
      expect(user.name).to eq("Samuel Birnbaum")
    end

    it "should keep already capitalized names the same" do
      user = User.create!(name: "Samuel Birnbaum", email:"s@gmail.com", password: "password")
      expect(user.name).to eq("Samuel Birnbaum")
    end

  end
end
