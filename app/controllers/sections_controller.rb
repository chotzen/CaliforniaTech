class SectionsController < ApplicationController
  def show
    @section = Section.friendly.find(params[:id])
    @articles = Article.published.where(section_id: @section.id)
  end
end
