# Lists all Articles and shows specific ones.
# Responds either to HTML and ATOM requests.
require_dependency "application_controller"


class ArticlesController < ApplicationController

  layout 'application'

  KEYWORDS = CONFIG[:keywords]
  SITE_TITLE = CONFIG[:title]

  # Lists all published articles.
  # Responds to html and atom
  def index
    respond_to do |format|
      format.html {
        @main = FeatureSlot.where(position: :main).first.article
        @opinion = FeatureSlot.where(position: :opinion).has_article.map {|fs| fs.article}
        @side_news = FeatureSlot.where(position: :side_news).has_article.map {|fs| fs.article}
        @faculty_profile = FeatureSlot.where(position: :faculty_profile).first.article
        @culture_feature = FeatureSlot.where(position: :culture_feature).first.article

        @other_news = Article.where(feature_slot_id: nil).where.not(section_id: 6).published.limit(5)
        @announcements = Article.where(section_id: 6).published.limit(5)

        set_meta_tags title: SITE_TITLE,
                      description: CONFIG[:meta_description],
                      keywords: KEYWORDS,
                      open_graph: { title: SITE_TITLE,
                                      type: 'website',
                                      url: articles_url,
                                      site_name: SITE_TITLE,
                                      image: CONFIG[:og_logo]
                                    }

      }
      format.atom{
        @articles = Article.published
      }
    end
  end

  # Shows specific article
  def show
    @first_page = true
    @article = Article.published.find(params[:id])
    @article.teaser = nil unless @article.teaser.present?
    meta_tags = { title: @article.title,
      type: 'article',
      url: url_for(@article),
      site_name: SITE_TITLE,
    }
    meta_tags[:image] = CONFIG[:host] + @article.image_url if @article.image_url.present?
    set_meta_tags title: @article.title,
                  keywords: KEYWORDS + @article.tag_list.to_s,
                  open_graph: meta_tags
    if request.path != article_path(@article)
      return redirect_to @article, status: :moved_permanently
    end

    @related_articles = Article.published.where('id != ?', @article.id).order('').limit(2)
  end

end