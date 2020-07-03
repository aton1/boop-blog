require 'rails_helper'

RSpec.feature "Delete Article" do
  let(:blogger) { create(:blogger) }
  let(:article) { create(:article, user: blogger) }

  context "when deleting an article" do
    before do
      sign_in_as(blogger)
    end

    scenario "signs in as a blogger" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "deletes their article" do
      visit "/articles/#{article.id}"
      click_button ("Delete")

      expect(page).to have_content("Boop article was deleted successfully.")
      expect(Article.count).to be(0)
    end
  end

  context "when trying to delete an article without signing in" do
    before do
      visit "/articles/#{article.id}"
    end

    scenario "tries to delete an article" do
      expect(page).not_to have_css(".button_to")
    end
  end
end
