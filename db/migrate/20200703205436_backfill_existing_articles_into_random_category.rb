class BackfillExistingArticlesIntoRandomCategory < ActiveRecord::Migration[6.0]
  def up
    articles = Article.all
    category = Category.find_by(id: 1)

    articles.each do |article|
      category.articles << article
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
