class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :display_name
      t.string :tag_color

      t.timestamps
    end

    add_reference :articles, :section
  end
end
