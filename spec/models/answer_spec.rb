require 'rails_helper'

RSpec.describe Answer, type: :model do
  
  let(:question) { Question.create!(title: "question title", body: "question body", resolved: false) }
  let(:answer) { Answer.create!(body: "this is my answer", question: question) }
  
  describe "attributes" do
    it "has body and foreign key attributes" do
      expect(answer).to have_attributes(body: "this is my answer", question: question)
    end
  end
end
