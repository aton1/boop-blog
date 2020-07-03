require 'rails_helper'

RSpec.feature "View Articles" do
  let(:blogger) { create(:blogger) }
  let(:article) { create(:article, user: blogger) }

  context "when viewing articles as a blogger" do
    before do
      sign_in_as(blogger)
    end

    scenario "signs in as a blogger" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "view articles on the index page" do
      article
      visit "/articles"

      expect(page).to have_content(article.title)
    end

    scenario "views article show page" do
      visit "/articles/#{article.id}"

      expect(page).to have_content("#{article.title}")
      expect(page).to have_css(".button_to")
    end
  end

  context "when viewing articles as a logged out blogger" do
    before do
      visit "/articles/#{article.id}"
    end

    scenario "views article on the show page" do
      expect(page).to have_content("#{article.title}")
      expect(page).not_to have_css(".button_to")
    end
  end
end
