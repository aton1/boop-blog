require 'rails_helper'

RSpec.feature "Create Article" do
  let(:blogger) { create(:blogger) }
  let(:article) { build(:article) }
  let(:category) { create(:category) }

  context "when creating an article" do
    before do
      sign_in_as(blogger)
    end

    scenario "signs in as a blogger" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "creates an article" do
      visit "/articles/new"
      fill_in "Title", with: article.title
      fill_in "Description", with: article.description
      click_button "Create Boop"

      expect(page).to have_content("Boop article was created successfully.")
    end

    scenario "creates an invalid article" do
      visit "/articles/new"
      fill_in "Title", with: "a"
      fill_in "Description", with: "test"
      click_button "Create Boop"

      expect(page).to have_css("div.alert")
      expect(Article.count).to be(0)
    end

    scenario "creates an article with a category" do
      category
      visit "/articles/new"
      fill_in "Title", with: article.title
      fill_in "Description", with: article.description
      page.select("#{category.name}", from: "article_category_ids")
      click_button "Create Boop"

      expect(page).to have_content("Boop article was created successfully.")
    end
  end

  context "when creating an article without logging in" do
    scenario "can't create an article if not logged in" do
      visit "/articles/new"

      expect(page).to have_content("You need to be logged in.")
    end
  end
end
