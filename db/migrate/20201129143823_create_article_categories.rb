class CreateArticleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :article_categories do |t|
      t.references :category
      t.references :article

      t.timestamps
    end
  end
end
