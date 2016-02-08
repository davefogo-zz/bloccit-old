require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:my_advertisement) {Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 299.99)}
end
