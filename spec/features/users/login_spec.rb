require 'rails_helper'

RSpec.feature "Login" do
  let(:admin_user) { create(:admin) }
  let(:blogger) { create(:blogger) }
  let(:invalid_user) { build(:blogger, username: blogger.username) }

  context "when logging in as an admin" do
    before do
      sign_in_as(admin_user)
    end

    scenario "signs in as admin user" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "has admin label next to username" do
      expect(page).to have_content("(Admin) #{admin_user.username}")
    end
  end

  context "when logging in as a blogger" do
    before do
      sign_in_as(blogger)
    end

    scenario "signs in as admin user" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "doesn't have admin label next to username" do
      expect(page).to have_content("#{blogger.username}")
    end
  end

  scenario "signs in with incorrect credentials" do
    sign_in_as(invalid_user)

    expect(page).to have_css("div.alert")
  end
end
