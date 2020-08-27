class AddImageHiddenToFeatureSlots < ActiveRecord::Migration[5.2]
  def change
    add_column :feature_slots, :hide_image, :boolean, default: true
  end
end
