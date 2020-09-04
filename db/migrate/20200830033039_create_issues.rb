class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.integer :volume
      t.integer :issue
      t.datetime :date
      t.string :file
      t.string :preview_image
      t.boolean :published, default: false

      t.timestamps
    end

    add_column :issues, :slug, :string
    add_index :issues, :slug, unique: true

    add_reference :articles, :issue
  end
end
