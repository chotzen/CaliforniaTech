class FeatureSlot < ApplicationRecord
  enum :position => [:main, :side_news, :opinion, :faculty_profile, :culture_feature]
  has_one :article
  accepts_nested_attributes_for :article

  scope :has_article, -> {
    where("id IN (SELECT feature_slot_id FROM Articles)").order(:priority)
  }

  def article_attributes=(article_attrs)
    if article_attrs[:id].empty?
      self.article = nil
    else
      self.article = Article.find(article_attrs[:id])
    end
  end
end
