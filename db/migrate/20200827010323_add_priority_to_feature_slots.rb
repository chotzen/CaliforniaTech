class AddPriorityToFeatureSlots < ActiveRecord::Migration[5.2]
  def change
    add_column :feature_slots, :priority, :integer, default: 1
  end
end
