class CreateFeatureSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :feature_slots do |t|
      t.integer :position

      t.timestamps
    end

    create_table :features do |t|
      t.integer :priority
      t.belongs_to :article
      t.belongs_to :feature_slot

      t.timestamps
    end

  end
end
