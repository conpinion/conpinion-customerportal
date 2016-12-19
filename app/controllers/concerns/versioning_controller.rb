module VersioningController

  extend ActiveSupport::Concern

  def restore
    model_class = versioned_model.capitalize.constantize
    object = model_class.find(params[:id]).specific_version params[:version]
    update_restored_object object
    redirect_to object
  end

  private
  def versioned_model
    @versioned_model ||= self.class.name.underscore.split('_').first.singularize
  end

  def update_restored_object object
    object.save!
  end
end
