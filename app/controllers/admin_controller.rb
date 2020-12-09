class AdminController < ApplicationController


  before_action :authenticate_administrator!
  before_action :halt_updates_not_from_authorized_administrator,
    except: [
      :edit,
      :index,
      :new,
      :show
    ]

  rescue_from ActionController::MethodNotAllowed, with: :alert_action_not_authorized



  protected


  def alert_action_not_authorized
    flash[:alert] = 'Action not authorized.'
    redirect_back(fallback_location: admin_root_path)
  end


  def halt_updates_not_from_authorized_administrator
    if current_administrator == nil
      raise ActionController::MethodNotAllowed.new('owner')
    elsif current_administrator.does_not_have_authority_to_write
      raise ActionController::MethodNotAllowed.new('owner')
    end
  end


end
