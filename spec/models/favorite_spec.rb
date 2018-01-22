require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:user) {User.create!(name: "Samuel", email:"s@gmail.com", password: "password")}
  let(:post) {Post.create!(title: "my post", body: "the body of my post!", topic_id: topic.id, user_id: user.id)}
  let(:favorite) {Favorite.create!(user: user, post: post)}

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
end
