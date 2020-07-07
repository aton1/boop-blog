require 'rails_helper'

RSpec.describe "articles", type: :request do
  let(:article) { create(:article) }
  let(:blogger) { article.user }
  let(:article_info) { build(:article) }
  let(:params) { { article: { title: article_info.title, description: article_info.description } } }

  context "when viewing articles" do
    it "articles#index" do
      get articles_path

      expect(response).to be_successful
    end

    it "articles#show" do
      get article_path(article)

      expect(response).to be_successful
    end
  end

  context "when user is logged in" do
    before do
      sign_in_as(blogger)
    end

    it "articles#new" do
      get new_article_path

      expect(response).to be_successful
    end

    it "articles#edit" do
      get edit_article_path(article)

      expect(response).to be_successful
    end

    it "articles#create" do
      post articles_path, params: params

      expect(Article.count).to be(2)
      expect(response).to redirect_to article_path(Article.last)
    end

    it "articles#update" do
      patch article_path(article), params: { article: { title: "Updated Title" } }

      expect(response).to redirect_to article_path(article)
    end

    it "articles#destroy" do
      delete article_path(article)

      expect(Article.count).to be(0)
      expect(response).to redirect_to articles_path
    end
  end

  context "when trying to create, update, or delete without signing in" do
    it "should not create article" do
      post articles_path, params: params

      expect(Article.count).not_to be(1)
    end

    it "should not update article" do
      patch article_path(article), params: params

      expect(response).to redirect_to login_path
    end

    it "should not delete article" do
      delete article_path(article)

      expect(Article.count).not_to be(0)
      expect(response).to redirect_to login_path
    end
  end
end
