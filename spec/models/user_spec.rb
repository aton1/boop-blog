require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user2) { build(:user, email: user.email) }

  it "is valid when all requirements are met" do
    expect(user).to be_valid
  end

  context "when checking validations for username" do
    it "is invalid with empty username" do
      user.username = nil
  
      expect(user).not_to be_valid
    end

    it "is invalid if username is too short" do
      user.username = "a"

      expect(user).not_to be_valid
    end

    it "is invalid if username is too long" do
      user.username = "a" * 26

      expect(user).not_to be_valid
    end

    it "is invalid if username is already taken" do
      user2.save

      expect(user2).not_to be_valid
    end
  end

  context "when checking validations for email" do
    it "is invalid with empty email" do
      user.email = nil
  
      expect(user).not_to be_valid
    end

    it "is invalid if email is too long" do
      user.email = user.email * 200

      expect(user).not_to be_valid
    end

    it "is invalid if email doesn't match regex" do
      user.email = "hello@test"

      expect(user).not_to be_valid
    end

    it "is invalid if email is already taken" do
      user2.save

      expect(user2).not_to be_valid
    end
  end

  it "is invalid with empty password" do
    user.password = nil
    
    expect(user).not_to be_valid
  end
end
