require 'random_data'

FactoryGirl.define do
  factory :post do
    title RandomData.random_name
    body RandomData.random_paragraph
    topic
    user
    rank 0.0
  end
end
