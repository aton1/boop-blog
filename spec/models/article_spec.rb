require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create(:article) }

  it "is valid when all requirements are met" do
    expect(article).to be_valid
  end

  it "has many categories" do
    expect(Article.reflect_on_association(:categories).macro).to eq(:has_many)
    expect(article).to respond_to(:categories)
  end

  context "when validating title" do
    it "is invalid when title is empty" do
      article.title = nil

      expect(article).not_to be_valid
    end

    it "is invalid when title is too short" do
      article.title = "ab"

      expect(article).not_to be_valid
    end

    it "is invalid when title is too long" do
      article.title = "ab" * 102

      expect(article).not_to be_valid
    end
  end

  context "when validating description" do
    it "is invalid when description is empty" do
      article.description = nil

      expect(article).not_to be_valid
    end

    it "is invalid when description is too short" do
      article.description = "abcd"

      expect(article).not_to be_valid
    end

    it "is invalid when description is too long" do
      article.description = "abcd" * 350

      expect(article).not_to be_valid
    end
  end
end
