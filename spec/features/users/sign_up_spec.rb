require 'rails_helper'

RSpec.feature "Sign Up" do
  let(:blogger) { build(:blogger) }
  let(:invalid_blogger) { build(:blogger, email: "test@test") }

  context "when signing up for boop" do
    scenario "signs up as a blogger" do
      sign_up_as(blogger)

      expect(page).to have_content("Welcome to boop, #{blogger.username}!")
    end

    scenario "signs up with incorrect email format" do
      sign_up_as(invalid_blogger)

      expect(page).to have_css("div.alert")
      expect(User.count).to be(0)
    end
  end
end
