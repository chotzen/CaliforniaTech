require_dependency "admin/application_controller"

module Admin

  class FeatureSlotsController < ApplicationController

    def index
      @feature_slots = FeatureSlot.order("position, priority")
      @articles = Article.published
    end

    def update
      @feature_slot = FeatureSlot.find params[:id]
      @feature_slot.update(feature_slots_params)
      redirect_to admin_feature_slots_path
    end

    private

    def feature_slots_params
      params.require(:feature_slot).permit(:hide_image, article_attributes: [:id])
    end

  end
end