require 'random_data'

FactoryGirl.define do
  factory :label do
    name RandomData.random_sentence
  end
end
