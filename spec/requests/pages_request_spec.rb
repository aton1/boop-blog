require 'rails_helper'

RSpec.describe "Pages", type: :request do
  let(:blogger) { create(:blogger) }

  context "when verifying pages#home" do
    it "redirects to articles#index if user is logged in" do
      sign_in_as(blogger)
      get root_path

      expect(response).to redirect_to(articles_path)
    end

    it "redirects to root path if user is not logged in" do
      get root_path

      expect(response).to be_successful
    end
  end

  context "when verifying pages#about" do
    it "pages#about" do
      get about_path

      expect(response).to be_successful
    end
  end
end
