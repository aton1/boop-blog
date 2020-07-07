require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }
  let(:category2) { build(:category, name: category.name) }

  it "is valid with valid attributes" do
    expect(category).to be_valid
  end

  it "has many articles" do
    expect(Category.reflect_on_association(:articles).macro).to eq(:has_many)
    expect(category).to respond_to(:articles)
  end

  it "is invalid if name is empty" do
    category.name = " "

    expect(category).not_to be_valid
  end

  it "is invalid if names are not unique" do
    category2.save
  
    expect(category2).not_to be_valid
  end

  it "is invalid if name is too long" do
    category.name = "a" * 30

    expect(category).not_to be_valid
  end

  it "is invalid if name is too short" do
    category.name = "a"

    expect(category).not_to be_valid
  end
end
