require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) {Answer.create!(body: "New Body", question_id: 1)}

  describe "attributes" do
    it "responds to body" do
      expect(answer).to respond_to(:body)
    end
    it "responds to question reference" do
      expect(answer).to respond_to(:question_id)
    end
  end
end
