require 'rails_helper'

RSpec.feature "View Categories" do
  let(:admin_user) { create(:admin) }
  let(:blogger) { create(:blogger) }
  let(:category) { create(:category) }

  context "when viewing categories as an admin" do
    before do
      category
      sign_in_as(admin_user)
    end

    scenario "signs in as admin user" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "view categories on the index page" do
      visit "/categories"

      expect(page).to have_content(category.name)
    end

    scenario "views category show page" do
      visit "/categories"
      click_on "#{category.name}"

      expect(page).to have_content("Category: #{category.name}")
      expect(page).to have_css(".text-center:nth-of-type(2)")
    end
  end

  context "when viewing categories as a blogger" do
    before do
      category
      sign_in_as(blogger)
      visit "/categories"
      click_on "#{category.name}"
    end

    scenario "views category on the show page" do
      expect(page).to have_content("Category: #{category.name}")
      expect(page).not_to have_content("Edit Category")
      expect(page).not_to have_content("Delete Category")
    end
  end
end
