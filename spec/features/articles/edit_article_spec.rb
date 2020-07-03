require 'rails_helper'

RSpec.feature "Edit Article" do
  let(:blogger) { create(:blogger) }
  let(:article) { create(:article, user: blogger) }

  context "when blogger edits their article" do
    before do
      sign_in_as(blogger)
    end

    scenario "signs in as a blogger" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "edits their article" do
      visit "/articles/#{article.id}/edit"
      fill_in "Title", with: "Updated - #{article.title}"
      click_button "Update Boop"

      expect(page).to have_content("Updated - #{article.title}")
    end

    scenario "updates article to be invalid" do
      visit "/articles/#{article.id}/edit"
      fill_in "Description", with: "a"
      click_button "Update Boop"

      expect(page).to have_css("div.alert")
    end
  end

  context "when logged out user tries to edit an article" do
    scenario "logged out user receives a flash message" do
      visit "/articles/#{article.id}/edit"

      expect(page).to have_content("You need to be logged in.")
    end
  end
end
