class IssuesController < ApplicationController
  def index
    @issues = Issue.where(published: true)
  end

  def show
    @issue = Issue.friendly.find(params[:id])
    @articles = @issue.articles.order(:section_id)
  end

  def edit
  end
end
