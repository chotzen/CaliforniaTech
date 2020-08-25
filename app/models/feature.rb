class Feature < ApplicationRecord
  belongs_to :feature_slot
  belongs_to :article, optional: true
end
