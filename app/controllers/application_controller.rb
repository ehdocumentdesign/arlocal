class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception, prepend: true
  before_action :determine_arlocal_settings


  rescue_from ActiveRecord::RecordNotFound, with: :error_record_not_found



  layout 'application'


  def error_action_not_authorized
    render 'errors/action_not_authorized', status: 401
  end


  def error_matching_route_not_found
    render 'errors/record_not_found', status: 404
  end


  def error_record_not_found
    render 'errors/record_not_found', status: 404
  end



  protected


  def after_sign_in_path_for(administrator)
    session["administrator_return_to"] || admin_root_path
  end


  def determine_arlocal_settings
    @arlocal_settings = QueryArlocalSettings.get
  end


end
