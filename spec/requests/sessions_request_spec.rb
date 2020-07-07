require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:blogger) { create(:blogger) }
  let(:invalid_credentials) { build(:blogger, email: blogger.email) }
  let(:params) { { session: { email: invalid_credentials.email, password: invalid_credentials.password } } }

  it "sessions#new" do
    get login_path

    expect(response).to be_successful
  end

  context "when sessions#create" do
    it "creates a session" do
      sign_in_as(blogger)

      expect(response).to redirect_to(user_path(blogger))
    end

    it "displays new form if invalid login credentials" do
      post login_path, params: params

      expect(flash[:alert]).to include("Invalid login credentials.")
      expect(response.body).to include("Login")
    end
  end

  it "sessions#destroy" do
    delete logout_path

    expect(session[:user_id]).to be_nil
    expect(response).to redirect_to(root_path)
  end

  it "invalid login" do
    post login_path, params: params

    expect(flash[:alert]).to include("Invalid login credentials.")
  end
end
