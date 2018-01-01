require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let(:my_topic) {Topic.create!(name: "i am a topic", description:"i am a description")}
  let(:my_spost) {SponsoredPost.create!(title: "spost title", body: "spost descrip", price: 3000000, topic_id: my_topic.id)}
  
  it { should belong_to(:topic) } 

  describe "attributes" do
    it "this model has attribures @title @body @price @topic_id" do
      expect(my_spost).to have_attributes(title: "spost title", body: "spost descrip", price: 3000000, topic_id: my_topic.id)
    end
  end
end
