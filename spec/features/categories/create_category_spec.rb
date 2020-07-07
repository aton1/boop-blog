require 'rails_helper'

RSpec.feature "Create Category" do
  let(:admin_user) { create(:admin) }
  let(:blogger) { create(:blogger) }
  let(:category) { build(:category) }

  context "when creating category as admin" do
    before do
      sign_in_as(admin_user)
    end

    scenario "signs in as admin user" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "creates a valid category" do
      visit "/categories/new"
      fill_in "Category Name", with: category.name
      click_button "Create Category"

      expect(page).to have_content("Category was successfully created.")
    end

    scenario "creates an invalid category" do
      visit "/categories/new"
      fill_in "Category Name", with: "a"
      click_button "Create Category"

      expect(page).to have_css("div.alert")
      expect(Category.count).to be(0)
    end
  end

  context "when creating category as blogger" do
    before do
      sign_in_as(blogger)
      visit "/categories/new"
    end

    scenario "can't create a category" do
      expect(page).to have_content("Only admins can perform that action")
    end
  end
end
