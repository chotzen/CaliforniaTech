class AddHeroCaptionToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :hero_caption, :text
  end
end
