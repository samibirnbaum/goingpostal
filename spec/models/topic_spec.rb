require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:description) {RandomData.random_paragraph}
  let(:public) {true}
  let(:topic) {Topic.create!(name: name, description: description)}

  it { is_expected.to have_many(:posts) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:public) }

  it { should validate_length_of(:name).is_at_least(5) }
  it { should validate_length_of(:description).is_at_least(15) }

  describe "attributes of the model" do
    it "has all the attributes we generated it with" do
      expect(topic).to have_attributes(name: name, description: description, public: public)
    end

    it "creates @public as true by default" do
      expect(topic.public).to be(true)
    end
  end

end
