require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:factory_topic) {create(:topic)}

  it { is_expected.to have_many(:posts) }

  describe "attributes of the model" do
    it "has all the attributes we generated it with" do
      expect(factory_topic).to have_attributes(name: factory_topic.name, description: factory_topic.description)
    end

    it "creates @public as true by default" do
      expect(factory_topic.public).to be(true)
    end
  end

end
