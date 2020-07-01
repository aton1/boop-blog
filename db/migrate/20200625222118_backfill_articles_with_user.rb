class BackfillArticlesWithUser < ActiveRecord::Migration[6.0]
  def up
    Article.where(user_id: nil).update(user_id: 1)
  end

  def down
    # raise ActiveRecord::IrreversibleMigration
    Article.where(user_id: nil).update(user_id: nil)
  end
end
