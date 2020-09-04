class AddSlugToSections < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :slug, :string
    add_index :sections, :slug, unique: true
  end
end
