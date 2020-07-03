require 'rails_helper'

RSpec.feature "View Users" do
  let(:admin_user) { create(:admin) }
  let(:blogger) { create(:blogger) }
  let(:article) { create(:article, user: admin_user) }

  context "when viewing users logged in as an admin" do
    before do
      article
      sign_in_as(admin_user)
    end

    scenario "signs in as admin user" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "view users on the index page" do
      visit "/users"

      expect(page).to have_content(admin_user.username)
    end

    scenario "has view, edit, and delete buttons" do
      visit "/users"

      expect(page).to have_css(".button_to:nth-of-type(1)")
      expect(page).to have_css(".button_to:nth-of-type(2)")
      expect(page).to have_css(".button_to:nth-of-type(3)")
    end

    scenario "views user show page with article listings" do
      visit "/users/#{admin_user.id}"

      expect(page).to have_content("#{admin_user.username}")
      expect(page).to have_css(".button_to")
      expect(page).to have_css(".card")
    end
  end

  context "when viewing users logged in as a blogger" do
    before do
      article
      sign_in_as(blogger)
    end

    scenario "signs in as a blogger" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "view users on the index page" do
      visit "/users"

      expect(page).to have_content(blogger.username)
    end

    scenario "has view and edit buttons on index page" do
      visit "/users"

      expect(page).to have_css(".button_to:nth-of-type(1)")
      expect(page).to have_css(".button_to:nth-of-type(2)")
    end

    scenario "views user show page with no article listings" do
      visit "/users/#{blogger.id}"

      expect(page).to have_content("#{blogger.username}")
      expect(page).to have_content("No boops yet :(")
    end
  end
end
