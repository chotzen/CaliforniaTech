require_dependency "admin/application_controller"

module Admin
  class IssuesController < ApplicationController

    def index
      @issues = Issue.all
    end

    def new
      @issue = Issue.new()
    end

    def create
      @issue = Issue.new(issue_params)

      if @issue.save
        redirect_to admin_issue_path @author
      else
        render action: "new"
      end
    end

    def edit
      @issue = Issue.friendly.find(params[:id])
    end

    def update
      @issue = Issue.friendly.find(params[:id])

      if @issue.update_attributes(issue_params)
        redirect_to admin_issue_path(@author)
      else
        render action: "edit"
      end
    end

    def show
      @issue = Issue.friendly.find(params[:id])
      @articles = @issue.articles.order(:section_id)
    end

    def toggle_publish
      issue = Issue.friendly.find(params[:id])
      if issue.published
        issue.update(published: false)
      else
        issue.update(published: true)
        issue.articles.update_all(published: true)
      end
    end

    private

    def issue_params
      params.require(:issue).permit(:volume, :issue, :date, :file, :preview_image, articles_attributes: [:id])
    end
  end

end