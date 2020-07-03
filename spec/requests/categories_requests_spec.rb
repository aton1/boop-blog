require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:category) { create(:category) }
  let(:category2) { build(:category, name: "Programming") }
  let(:admin_user) { create(:admin) }
  let(:params) { { category: { name: category2.name } } }

  context "when viewing categories" do
    it "categories#index" do
      get categories_path

      expect(response).to be_successful
    end

    it "categories#show" do
      get category_path(category)

      expect(response).to be_successful
    end
  end

  context "when admin user is logged in" do
    before do
      sign_in_as(admin_user)
    end

    it "categories#new" do
      get new_category_path

      expect(response).to be_successful
    end

    it "categories#edit" do
      get edit_category_path(category)

      expect(response).to be_successful
    end

    it "categories#create" do
      post categories_path, params: params

      expect(Category.count).to be(1)
      expect(response).to redirect_to category_path(Category.last)
    end

    it "categories#update" do
      patch category_path(category), params: { category: { name: "Updated Name" } }

      expect(response).to redirect_to category_path(category)
    end

    it "categories#destroy" do
      delete category_path(category)

      expect(Category.count).to be(0)
      expect(response).to redirect_to categories_path
    end
  end

  context "when trying to create, update, or delete without admin role" do
    it "should not create category" do
      post categories_path, params: params

      expect(Category.count).not_to be(1)
    end

    it "should not update category" do
      patch category_path(category), params: params

      expect(response).to redirect_to categories_path
    end

    it "should not delete category" do
      delete category_path(category)

      expect(Category.count).not_to be(0)
      expect(response).to redirect_to categories_path
    end
  end
end
