require 'rails_helper'

RSpec.feature "Delete Category" do
  let(:admin_user) { create(:admin) }
  let(:blogger) { create(:blogger) }
  let(:category) { create(:category) }

  context "when deleting category as an admin" do
    before do
      sign_in_as(admin_user)
    end
    
    scenario "signs in as admin user" do
      expect(page).to have_content("Logged in successfully.")
    end

    scenario "deletes a valid category" do
      visit "/categories/#{category.id}"
      click_button ("Delete Category")

      expect(page).to have_content("Category was successfully deleted.")
      expect(Category.count).to be(0)
    end
  end

  context "when trying to delete a category as a blogger" do
    before do
      sign_in_as(blogger)
      visit "/categories/#{category.id}"
    end
    
    scenario "tries to delete category" do
      expect(page).not_to have_css(".text-center:nth-of-type(2) > .button_to:nth-of-type(2)")
    end
  end
end
