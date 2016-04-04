require 'random_data'

FactoryGirl.define do
  factory :vote do
    value 1
    post
    user
  end
end
