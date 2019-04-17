class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit

  def after_sign_in_path_for user
    root_path
  end

  def after_sign_out_path_for user
    new_user_session_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:alert] = exception.message
    render 'errors/401', status: 401
  end

  def welcome
    redirect_to new_user_session_path unless current_user
  end

  class << self
    alias before_filter before_action
  end
end
