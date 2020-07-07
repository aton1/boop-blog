require 'rails_helper'

RSpec.feature "Edit Category" do
  let(:admin_user) { create(:admin) }
  let(:blogger) { create(:blogger) }
  let(:category) { create(:category) }

  context "when admin edits a category" do
    before do
      sign_in_as(admin_user)
    end

    scenario "signs in as admin user" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "edits an existing category" do
      visit "/categories/#{category.id}/edit"
      fill_in "Category Name", with: "Updated - #{category.name}"
      click_button "Update Category"

      expect(page).to have_content("Updated - #{category.name}")
    end

    scenario "updates category to be invalid" do
      visit "/categories/#{category.id}/edit"
      fill_in "Category Name", with: "a"
      click_button "Update Category"

      expect(page).to have_css("div.alert")
    end
  end

  context "when blogger tries to edit a category" do
    before do
      sign_in_as(blogger)
      visit "/categories/#{category.id}/edit"
    end

    scenario "blogger will be shown a flash message" do
      expect(page).to have_content("Only admins can perform that action")
    end
  end
end
