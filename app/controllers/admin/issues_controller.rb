require_dependency "admin/application_controller"

module Admin
  class IssuesController < ApplicationController

    def index
      @published = Issue.where(published: true)
      @unpublished = Issue.where(published: false)
    end

    def new
      @issue = Issue.new(issue: Issue.current_issue)
      @articles = Article.where(issue: nil)
    end

    def create
      @issue = Issue.new(issue_params)

      if @issue.save
        redirect_to issue_path @issue
      else
        render action: "new"
      end
    end

    def edit
      @issue = Issue.friendly.find(params[:id])
      @articles = Article.where(issue: [nil, @issue])
    end

    def update
      @issue = Issue.friendly.find(params[:id])

      if @issue.update_attributes(issue_params)
        redirect_to issue_path(@issue)
      else
        render action: "edit"
      end
    end

    def show
      @issue = Issue.friendly.find(params[:id])
      @articles = @issue.articles.order(:section_id)
    end

    def toggle_publish
      issue = Issue.friendly.find(params[:issue_id])
      if issue.published
        issue.update(published: false)
      else
        issue.update(published: true)
        issue.articles.update_all(published: true)
      end
      redirect_to admin_issues_path
    end

    private

    def issue_params
      params.require(:issue).permit(:volume, :issue, :date, :file, :print_version, article_ids: [])
    end

  end
end