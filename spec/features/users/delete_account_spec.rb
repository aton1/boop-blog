require 'rails_helper'

RSpec.feature "Delete Account" do
  let(:blogger) { create(:blogger) }

  context "when deleting an account" do
    before do
      sign_in_as(blogger)
    end

    scenario "signs in as a blogger" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "deletes their account" do
      visit "/users/#{blogger.id}/edit"
      click_button ("Delete Account")

      expect(page).to have_content("Your account and all associated articles were successfully deleted.")
      expect(User.count).to be(0)
    end
  end

  context "when trying to delete an account without signing in" do
    before do
      visit "/users/#{blogger.id}"
    end

    scenario "tries to delete an account" do
      expect(page).not_to have_css(".button_to")
    end
  end
end
