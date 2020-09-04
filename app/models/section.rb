class Section < ApplicationRecord
  extend FriendlyId
  has_many :articles
  friendly_id :display_name, use: :slugged
end
