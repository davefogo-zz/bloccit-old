require 'rails_helper'
require 'random_data'

RSpec.describe User, type: :model do
  let(:user) { create(:user)}

  it {is_expected.to have_many(:posts)}
  it {is_expected.to have_many(:comments)}
  it {is_expected.to have_many(:votes)}
  it {is_expected.to have_many(:favorites)}

  #Shoulda tests for name
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_length_of(:name).is_at_least(1)}

  #Shoulda tests for email
  it {is_expected.to validate_presence_of(:email)}
  it {is_expected.to validate_uniqueness_of(:email)}
  it {is_expected.to validate_length_of(:email).is_at_least(3)}
  it {is_expected.to allow_value("user@bloccit.com").for(:email)}
  it {should_not allow_value("userbloccit.com").for(:email)}

  #Shoulda tests for password
  it {is_expected.to validate_presence_of(:password_digest)}
  it {is_expected.to have_secure_password}
  it {is_expected.to validate_length_of(:password_digest).is_at_least(6)}

  describe "attributes" do
    it "responds to name" do
      expect(user).to respond_to(:name)
    end

    it "responds to email" do
      expect(user).to respond_to(:email)
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
    it "is member by default" do
      expect(user.role).to eq("member")
    end

    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_name) {User.new(name: "", email: "user@bloccit.com")}
    let(:user_with_invalid_email) {User.new(name: "Bloccit User", email: "")}
    let(:user_with_invalid_email_format) {User.new(name: "Bloccit User", email: "invalid_format")}

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end

    it "should be an invalid user due to incorrectly formatted email address" do
      expect(user_with_invalid_email_format).to_not be_valid
    end
  end

  describe "#favorite_for(post)" do
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end

    it "returns nil if the user has not favorited the post" do
      expect(user.favorite_for(@post)).to be_nil
    end

    it "returns the appropiate favorite if it exists" do
      favorite = user.favorites.where(post: @post).create
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end

  describe ".avatar_url" do
    let(:known_user) {create(:user, email: "blochead@bloc.io")}

    it "returns the proper Gravatar url for a known email entity" do
      expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
      expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end
  end
end
