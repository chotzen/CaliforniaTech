class Issue < ApplicationRecord
  has_many :articles
  has_one_attached :print_version, dependent: false

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  accepts_nested_attributes_for :articles

  validates_presence_of :volume, :issue, :date
  validate :acceptable_pdf_file

  default_scope { order("volume DESC, issue DESC") }

  def acceptable_pdf_file
    return unless print_version.attached?

    unless print_version.byte_size <= 16.megabyte
      errors.add(:print_version, "is too big")
    end

    unless print_version.content_type == "application/pdf"
      errors.add(:print_version, "must be a PDF file")
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

  def pdf_url
    return dev_url if Rails.env.development?

    print_version.service_url.sub(/\?.*/, '')
  end

  private

  def dev_url
    Rails.application.routes.url_helpers.rails_blob_url(print_version, only_path: true)
  end

end
