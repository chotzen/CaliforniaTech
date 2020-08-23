class AddTeaserToArticle < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :teaser, :text
  end
end
