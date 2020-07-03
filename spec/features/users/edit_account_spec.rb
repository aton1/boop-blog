require 'rails_helper'

RSpec.feature "Edit Account" do
  let(:blogger) { create(:blogger) }

  context "when user edits their account" do
    before do
      sign_in_as(blogger)
    end

    scenario "signs in as a blogger" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "edits their account" do
      visit "/users/#{blogger.id}/edit"
      fill_in "Username", with: "Updated - #{blogger.username}"
      click_button "Update Account"

      expect(page).to have_content("Updated - #{blogger.username}")
    end

    scenario "updates account to be invalid" do
      visit "/users/#{blogger.id}/edit"
      fill_in "Email", with: "a"
      click_button "Update Account"

      expect(page).to have_css("div.alert")
    end
  end

  context "when nonuser tries to edit an account" do
    before do
      visit "/users/#{blogger.id}/edit"
    end

    scenario "nonuser will be shown a flash message" do
      expect(page).to have_content("You need to be logged in.")
    end
  end
end
