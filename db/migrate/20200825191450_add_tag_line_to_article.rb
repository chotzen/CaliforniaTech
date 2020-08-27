class AddTagLineToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :author_bio, :text, default: ""
  end
end
