class FeatureSlot < ApplicationRecord
  has_many :articles, through: :feature_slots
end
