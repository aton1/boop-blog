require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do
  let(:article) { create(:article) }
  let(:category) { create(:category) }

  it "belongs to article" do    
    expect(ArticleCategory.reflect_on_association(:article).macro).to eq(:belongs_to)
  end

  it "belongs to category" do
    expect(ArticleCategory.reflect_on_association(:category).macro).to eq(:belongs_to)
  end
end
