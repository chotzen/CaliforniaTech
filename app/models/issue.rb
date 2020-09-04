class Issue < ApplicationRecord
  has_many :articles
  has_one_attached :print_version, dependent: false
  has_one_attached :print_version_thumbnail, dependent: false

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  accepts_nested_attributes_for :articles

  validates_presence_of :volume, :issue, :date
  validate :acceptable_pdf_file

  def acceptable_pdf_file
    return unless print_version.attached?

    unless print_version.byte_size <= 16.megabyte
      errors.add(:print_version, "is too big")
    end

    unless print_version.content_type == "application/pdf"
      errors.add(:print_version, "must be a PDF file")
    end
  end

  def acceptable_thumbnail
    return unless print_version_thumbnail.attached?

    unless print_version_thumbnail.byte_size <= 16.megabyte
      errors.add(:print_version_thumbnail, "is too big")
    end

    unless ["image/jpeg", "image/png"].include? print_version_thumbnail.content_type
      errors.add(:print_version_thumbnail, "must be a JPEG or PNG file")
    end
  end

  def slug_candidates
    ["#{volume}-#{issue}"]
  end

  def self.current_volume
    124
  end

  def self.current_issue
    self.where(volume: 124).count + 1
  end
end
