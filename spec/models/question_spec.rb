require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:my_question) {Question.create!(title: "A Question title", body: "A Question body", resolved: false)}

  describe "attributes" do
    it "has attributes title, body, resolved" do
      expect(my_question).to have_attributes(title: "A Question title", body: "A Question body", resolved: false)
    end
  end
end
