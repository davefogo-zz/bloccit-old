require 'rails_helper'
require 'random_data'

RSpec.describe Post, type: :model do
  let (:user) {create (:user)}
  let(:topic) {create (:topic)}
  let(:post) {create (:post)}

  it {is_expected.to have_many(:labelings)}
  it {is_expected.to have_many(:labels).through(:labelings)}
  it {is_expected.to have_many(:comments)}
  it {is_expected.to have_many(:votes)}
  it {is_expected.to have_many(:favorites)}

  it {is_expected.to belong_to(:user)}
  it {is_expected.to belong_to(:topic)}

  #Shoulda test for posts
  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_presence_of(:topic)}
  it {is_expected.to validate_length_of(:title).is_at_least(5)}
  it {is_expected.to validate_length_of(:body).is_at_least(20)}

    describe "attributes" do

      it "responds to title" do
        expect(post).to respond_to(:title)
      end

      it "responds to body" do
        expect(post).to respond_to(:body)
      end
    end

    describe "voting" do

      before do
        3.times {post.votes.create!(value: 1)}
        2.times {post.votes.create!(value: -1)}
        @up_votes = post.votes.where(value: 1).count
        @down_votes = post.votes.where(value: -1).count
      end

      describe "#up_votes" do

        it "counts the number of votes with value = 1" do
          expect(post.up_votes).to eq(@up_votes)
        end
      end

      describe "down_votes" do
        it "counts the number of votes with value = -1" do
          expect(post.down_votes).to eq(@down_votes)
        end
      end

      describe "points" do
        it "returns the sum of all down and up votes" do
          expect(post.points).to eq(@up_votes - @down_votes)
        end
      end

      describe "#update_rank" do
        it "calculates the correct rank" do
          post.update_rank
          expect(post.rank).to eq(post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
        end

        it "updates the rank when an up vote is created" do
          old_rank = post.rank
          post.votes.create!(value: 1)
          expect(post.rank).to eq(old_rank + 1)
        end

        it "updates the rank when a down vote is created" do
          old_rank = post.rank
          post.votes.create!(value:-1)
          expect(post.rank).to eq(old_rank - 1)
        end
      end
    end
end
