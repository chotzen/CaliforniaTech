class DropTableFeatures < ActiveRecord::Migration[5.2]
  def change
    drop_table :features
    add_reference :articles, :feature_slot
  end
end
