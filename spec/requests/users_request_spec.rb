require 'rails_helper'

RSpec.describe "Users", type: :request do
 let(:blogger) { create(:blogger) }
 let(:blogger2) { create(:blogger) }
 let(:new_blogger) { build(:blogger) }
 let(:params) { { user: { username: new_blogger.username, email: new_blogger.email, password: new_blogger.password } } }
 let(:invalid_params) { { user: { username: "abcd", email: "test", password: "password" } } }

  it "users#index" do
    get users_path

    expect(response).to be_successful
  end

  it "users#show" do
    get user_path(blogger)

    expect(response).to be_successful
  end

  it "users#new" do
    get sign_up_path

    expect(response).to be_successful
  end

  context "when users#edit" do
    it "edits user info if signed in and same user" do
      sign_in_as(blogger)
      get edit_user_path(blogger)

      expect(response).to be_successful
    end

    it "can't edit user info if signed in but not same user" do
      sign_in_as(blogger)
      get edit_user_path(blogger2)

      expect(flash[:alert]).to include("You can only edit or delete your own profile.")
    end

    it "can't edit user info if not signed in" do
      get edit_user_path(blogger)

      expect(flash[:alert]).to include("You need to be logged in.")
    end
  end

  context "when users#create" do
    it "creates new user" do
      post users_path, params: params

      expect(response).to redirect_to(user_path(User.last))
    end

    it "renders new form if user entered in invalid info" do
      post users_path, params: invalid_params

      expect(response.body).to include("Sign up")
    end
  end

  context "when users#update" do
    it "updates user info" do
      sign_in_as(blogger)
      patch user_path(blogger), params: { user: { username: "upd_username" } }

      expect(response).to redirect_to(user_path(blogger))
    end

    it "can only update user's own info" do
      sign_in_as(blogger)
      patch user_path(blogger2), params: { user: { username: "upd_username" } }

      expect(flash[:alert]).to include("You can only edit or delete your own profile.")
    end

    it "renders edit form if there were errors" do
      sign_in_as(blogger)
      patch user_path(blogger), params: { user: { username: "a" } }

      expect(response.body).to include("Edit")
    end
  end

  context "when users#destroy" do
    it "deletes user account" do
      sign_in_as(blogger)
      delete user_path(blogger)

      expect(response).to redirect_to(root_path)
    end

    it "can only delete user's own account" do
      sign_in_as(blogger)
      delete user_path(blogger2)

      expect(flash[:alert]).to include("You can only edit or delete your own profile.")
    end
  end
end
